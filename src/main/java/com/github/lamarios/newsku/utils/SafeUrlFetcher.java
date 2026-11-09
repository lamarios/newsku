package com.github.lamarios.newsku.utils;

import com.github.lamarios.newsku.Constants;
import java.io.FilterInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.Inet6Address;
import java.net.InetAddress;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.UnknownHostException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * Fetches urls coming from users or feeds (feeds, articles, images). Only http(s) urls are allowed,
 * to prevent reading local files, and unless ALLOW_PRIVATE_NETWORK_URLS is set they must point to
 * public addresses, to prevent reaching internal services. Redirects are followed manually so each
 * hop is checked the same way.
 */
@Component
public class SafeUrlFetcher {
  public static final long MAX_IMAGE_SIZE = 10 * 1024 * 1024;
  public static final long MAX_PAGE_SIZE = 20 * 1024 * 1024;
  private static final int MAX_REDIRECTS = 5;
  private static final int TIMEOUT_MS = 10_000;

  private final boolean allowPrivateNetwork;

  public SafeUrlFetcher(@Value("${ALLOW_PRIVATE_NETWORK_URLS:0}") boolean allowPrivateNetwork) {
    this.allowPrivateNetwork = allowPrivateNetwork;
  }

  /** Thrown when a url isn't allowed to be fetched */
  public static class UnsafeUrlException extends IOException {
    public UnsafeUrlException(String message) {
      super(message);
    }

    public UnsafeUrlException(String message, Throwable cause) {
      super(message, cause);
    }
  }

  /**
   * Opens the url, the returned stream fails if more than maxSize bytes are read and must be closed
   * by the caller
   */
  public InputStream open(String urlString, long maxSize) throws IOException {
    URL url = checkUrl(urlString);

    for (int i = 0; i <= MAX_REDIRECTS; i++) {
      HttpURLConnection connection = (HttpURLConnection) url.openConnection();
      connection.setInstanceFollowRedirects(false);
      connection.setConnectTimeout(TIMEOUT_MS);
      connection.setReadTimeout(TIMEOUT_MS);
      connection.setRequestProperty("User-Agent", Constants.USER_AGENT);

      try {
        int status = connection.getResponseCode();
        if (status >= 300 && status < 400) {
          String location = connection.getHeaderField("Location");
          connection.disconnect();
          if (location == null) {
            throw new IOException("Redirect without location");
          }
          url = checkUrl(url.toURI().resolve(location).toString());
          continue;
        }

        if (status != HttpURLConnection.HTTP_OK) {
          throw new IOException("Unexpected status " + status + " for " + urlString);
        }

        if (connection.getContentLengthLong() > maxSize) {
          throw new IOException("Response too large: " + urlString);
        }

        return new LimitedInputStream(connection, maxSize, urlString);
      } catch (IOException | URISyntaxException | RuntimeException e) {
        connection.disconnect();
        if (e instanceof IOException io) {
          throw io;
        }
        throw new IOException("Couldn't fetch " + urlString, e);
      }
    }

    throw new IOException("Too many redirects for " + urlString);
  }

  /** Downloads an image to the given path */
  public void downloadImageToPath(String urlString, Path path) throws IOException {
    // we write to a temp file first so a failed download doesn't leave a broken cache entry
    Path tmp = Files.createTempFile(path.getParent(), "download", ".tmp");
    try (InputStream in = open(urlString, MAX_IMAGE_SIZE);
        OutputStream out = Files.newOutputStream(tmp)) {
      in.transferTo(out);
    } catch (IOException e) {
      Files.deleteIfExists(tmp);
      throw e;
    }
    Files.move(tmp, path, StandardCopyOption.REPLACE_EXISTING);
  }

  /**
   * Makes sure the url is an http(s) url and, unless private networks are allowed, that its host
   * only resolves to public addresses
   *
   * @throws UnsafeUrlException if the url isn't allowed
   */
  public URL checkUrl(String urlString) throws UnsafeUrlException {
    URL url;
    try {
      url = new URI(urlString).toURL();
    } catch (URISyntaxException | IllegalArgumentException | IOException e) {
      throw new UnsafeUrlException("Invalid url: " + urlString, e);
    }

    String protocol = url.getProtocol();
    if (!"http".equalsIgnoreCase(protocol) && !"https".equalsIgnoreCase(protocol)) {
      throw new UnsafeUrlException("Only http(s) urls are allowed: " + urlString);
    }

    String host = url.getHost();
    if (host == null || host.isBlank()) {
      throw new UnsafeUrlException("Url without host: " + urlString);
    }

    if (allowPrivateNetwork) {
      return url;
    }

    InetAddress[] addresses;
    try {
      addresses = InetAddress.getAllByName(host);
    } catch (UnknownHostException e) {
      throw new UnsafeUrlException("Unknown host: " + host, e);
    }

    for (InetAddress address : addresses) {
      if (!isPublicAddress(address)) {
        throw new UnsafeUrlException(
            "Url points to a private network address, set ALLOW_PRIVATE_NETWORK_URLS to allow it: "
                + urlString);
      }
    }

    return url;
  }

  static boolean isPublicAddress(InetAddress address) {
    if (address.isAnyLocalAddress()
        || address.isLoopbackAddress()
        || address.isLinkLocalAddress()
        || address.isSiteLocalAddress()
        || address.isMulticastAddress()) {
      return false;
    }

    byte[] bytes = address.getAddress();
    if (address instanceof Inet6Address) {
      // unique local addresses fc00::/7
      if ((bytes[0] & 0xfe) == 0xfc) {
        return false;
      }
      // IPv4 mapped addresses ::ffff:a.b.c.d, check the embedded IPv4 address
      boolean mapped = bytes[10] == (byte) 0xff && bytes[11] == (byte) 0xff;
      for (int i = 0; i < 10 && mapped; i++) {
        mapped = bytes[i] == 0;
      }
      if (mapped) {
        try {
          return isPublicAddress(
              InetAddress.getByAddress(new byte[] {bytes[12], bytes[13], bytes[14], bytes[15]}));
        } catch (UnknownHostException e) {
          return false;
        }
      }
      return true;
    }

    int first = bytes[0] & 0xff;
    int second = bytes[1] & 0xff;
    // 0.0.0.0/8, carrier grade NAT 100.64.0.0/10, benchmarking 198.18.0.0/15, reserved 240.0.0.0/4
    return first != 0
        && !(first == 100 && second >= 64 && second <= 127)
        && !(first == 198 && (second == 18 || second == 19))
        && first < 240;
  }

  /** Stream that fails past a maximum size and closes the connection when closed */
  private static class LimitedInputStream extends FilterInputStream {
    private final HttpURLConnection connection;
    private final long maxSize;
    private final String url;
    private long read = 0;

    LimitedInputStream(HttpURLConnection connection, long maxSize, String url) throws IOException {
      super(connection.getInputStream());
      this.connection = connection;
      this.maxSize = maxSize;
      this.url = url;
    }

    private void count(long n) throws IOException {
      if (n > 0) {
        read += n;
        if (read > maxSize) {
          throw new IOException("Response too large: " + url);
        }
      }
    }

    @Override
    public int read() throws IOException {
      int b = super.read();
      count(b == -1 ? 0 : 1);
      return b;
    }

    @Override
    public int read(byte[] b, int off, int len) throws IOException {
      int n = super.read(b, off, len);
      count(n);
      return n;
    }

    @Override
    public long skip(long n) throws IOException {
      long skipped = super.skip(n);
      count(skipped);
      return skipped;
    }

    @Override
    public void close() throws IOException {
      try {
        super.close();
      } finally {
        connection.disconnect();
      }
    }
  }
}

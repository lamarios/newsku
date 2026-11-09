package com.github.lamarios.newsku.utils;

import static org.junit.jupiter.api.Assertions.*;

import java.io.IOException;
import java.net.InetAddress;
import java.nio.file.Files;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

public class SafeUrlFetcherTest {
  private final SafeUrlFetcher fetcher = new SafeUrlFetcher(false);
  private final SafeUrlFetcher privateNetworkFetcher = new SafeUrlFetcher(true);

  @ParameterizedTest
  @ValueSource(
      strings = {
        "file:///etc/passwd",
        "file:///proc/self/environ",
        "jar:file:///app.jar!/application.yml",
        "ftp://example.com/image.png",
        "not a url"
      })
  public void rejectsNonHttpUrlsEvenOnPrivateNetwork(String url) throws IOException {
    assertThrows(SafeUrlFetcher.UnsafeUrlException.class, () -> fetcher.checkUrl(url));
    assertThrows(
        SafeUrlFetcher.UnsafeUrlException.class, () -> privateNetworkFetcher.checkUrl(url));

    var dir = Files.createTempDirectory("url-fetcher-test");
    var path = dir.resolve("image");
    assertThrows(IOException.class, () -> privateNetworkFetcher.downloadImageToPath(url, path));
    assertFalse(Files.exists(path));
  }

  @ParameterizedTest
  @ValueSource(
      strings = {
        "http://localhost/image.png",
        "http://127.0.0.1:8080/api/users",
        "http://0.0.0.0/image.png",
        "http://10.0.0.1/image.png",
        "http://172.16.5.4/image.png",
        "http://192.168.1.1/feed.xml",
        "http://169.254.169.254/latest/meta-data/",
        "http://100.64.0.1/image.png",
        "http://[::1]/image.png",
        "http://[fd00::1]/image.png",
        "http://[fe80::1]/image.png",
        "http://[::ffff:127.0.0.1]/image.png"
      })
  public void rejectsPrivateAddressesUnlessAllowed(String url) throws IOException {
    assertThrows(SafeUrlFetcher.UnsafeUrlException.class, () -> fetcher.checkUrl(url));
    assertThrows(
        SafeUrlFetcher.UnsafeUrlException.class,
        () -> fetcher.open(url, SafeUrlFetcher.MAX_PAGE_SIZE));

    assertNotNull(privateNetworkFetcher.checkUrl(url));
  }

  @Test
  public void publicAddresses() throws IOException {
    assertTrue(SafeUrlFetcher.isPublicAddress(InetAddress.getByName("1.1.1.1")));
    assertTrue(SafeUrlFetcher.isPublicAddress(InetAddress.getByName("8.8.8.8")));
    assertTrue(SafeUrlFetcher.isPublicAddress(InetAddress.getByName("2606:4700:4700::1111")));
    assertTrue(SafeUrlFetcher.isPublicAddress(InetAddress.getByName("::ffff:8.8.8.8")));
  }
}

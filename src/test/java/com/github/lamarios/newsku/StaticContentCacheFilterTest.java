package com.github.lamarios.newsku;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.context.annotation.Import;

/**
 * Uses src/test/resources/web/test_precache_manifest.json and the files in
 * src/test/resources/public.
 */
@Import(TestConfig.class)
public class StaticContentCacheFilterTest extends TestContainerTest {
  @LocalServerPort private int port;

  private HttpResponse<String> get(String path) throws IOException, InterruptedException {
    try (HttpClient client = HttpClient.newHttpClient()) {
      return client.send(
          HttpRequest.newBuilder(URI.create("http://localhost:" + port + path)).GET().build(),
          HttpResponse.BodyHandlers.ofString());
    }
  }

  private static String cacheControl(HttpResponse<?> response) {
    return response.headers().firstValue("Cache-Control").orElse(null);
  }

  @Test
  public void testHashedFileIsImmutable() throws Exception {
    var response = get("/test.0123abcd.js");
    assertEquals(200, response.statusCode());
    assertEquals(StaticContentCacheFilter.IMMUTABLE, cacheControl(response));
  }

  @Test
  public void testNonHashedFileIsRevalidated() throws Exception {
    var response = get("/test-not-hashed.js");
    assertEquals(200, response.statusCode());
    assertEquals(StaticContentCacheFilter.REVALIDATE, cacheControl(response));

    // not in the manifest at all, e.g. index.html / flutter_bootstrap.js
    assertEquals(StaticContentCacheFilter.REVALIDATE, cacheControl(get("/")));
  }

  @Test
  public void testApiIsNotCached() throws Exception {
    var response = get("/api/users");
    assertEquals(401, response.statusCode());
    assertTrue(cacheControl(response).contains("no-store"), cacheControl(response));
  }
}

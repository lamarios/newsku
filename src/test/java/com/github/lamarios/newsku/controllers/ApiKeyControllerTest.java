package com.github.lamarios.newsku.controllers;

import static org.junit.jupiter.api.Assertions.*;

import com.github.lamarios.newsku.TestConfig;
import com.github.lamarios.newsku.TestContainerTest;
import com.github.lamarios.newsku.errors.NewskuUserException;
import com.github.lamarios.newsku.models.ApiKeyRequest;
import com.github.lamarios.newsku.persistence.repositories.ApiKeyRepository;
import com.github.lamarios.newsku.services.ApiKeyService;
import kong.unirest.core.Unirest;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.context.annotation.Import;

@Import(TestConfig.class)
public class ApiKeyControllerTest extends TestContainerTest {
  @Autowired private ApiKeyController apiKeyController;
  @Autowired private ApiKeyService apiKeyService;
  @Autowired private ApiKeyRepository apiKeyRepository;
  @LocalServerPort private int port;

  @AfterEach
  public void tearDown() {
    apiKeyRepository.deleteAll();
  }

  @Test
  public void testApiKeyCrud() throws NewskuUserException {
    var created = apiKeyController.createApiKey(new ApiKeyRequest("my key", null));
    assertNotNull(created.key());
    assertTrue(created.key().startsWith(ApiKeyService.KEY_PREFIX));
    assertEquals("my key", created.apiKey().getName());
    assertNull(created.apiKey().getExpiresAt());

    // plain key must never be stored
    var stored = apiKeyRepository.findById(created.apiKey().getId()).orElseThrow();
    assertNotEquals(created.key(), stored.getKeyHash());
    assertFalse(stored.getKeyHash().contains(created.key()));

    var keys = apiKeyController.getApiKeys();
    assertEquals(1, keys.size());
    assertNull(keys.getFirst().getLastUsed());

    long beforeUse = System.currentTimeMillis();
    assertTrue(apiKeyService.getUserFromKey(created.key()).isPresent());

    var lastUsed = apiKeyController.getApiKeys().getFirst().getLastUsed();
    assertNotNull(lastUsed);
    assertTrue(lastUsed >= beforeUse);
    assertTrue(apiKeyService.getUserFromKey("nsk_doesnotexist").isEmpty());

    assertTrue(apiKeyController.deleteApiKey(created.apiKey().getId()));
    assertTrue(apiKeyController.getApiKeys().isEmpty());
    assertTrue(apiKeyService.getUserFromKey(created.key()).isEmpty());
  }

  @Test
  public void testInvalidApiKeys() {
    assertThrows(
        NewskuUserException.class,
        () -> apiKeyController.createApiKey(new ApiKeyRequest(null, null)));
    assertThrows(
        NewskuUserException.class,
        () -> apiKeyController.createApiKey(new ApiKeyRequest(" ", null)));
    assertThrows(
        NewskuUserException.class,
        () ->
            apiKeyController.createApiKey(
                new ApiKeyRequest("expired", System.currentTimeMillis() - 1000)));
  }

  @Test
  public void testExpiredKeyIsRejected() throws NewskuUserException {
    var created =
        apiKeyController.createApiKey(
            new ApiKeyRequest("short lived", System.currentTimeMillis() + 60_000));
    assertTrue(apiKeyService.getUserFromKey(created.key()).isPresent());

    // force expiry
    var stored = apiKeyRepository.findById(created.apiKey().getId()).orElseThrow();
    stored.setExpiresAt(System.currentTimeMillis() - 1);
    apiKeyRepository.save(stored);

    assertTrue(apiKeyService.getUserFromKey(created.key()).isEmpty());
  }

  @Test
  public void testAuthenticateWithApiKey() throws NewskuUserException {
    var created = apiKeyController.createApiKey(new ApiKeyRequest("http", null));
    String url = "http://localhost:" + port + "/api/users";

    var response = Unirest.get(url).header("Authorization", created.key()).asString();
    assertEquals(200, response.getStatus());

    response = Unirest.get(url).header("Authorization", "nsk_wrongkey").asString();
    assertEquals(401, response.getStatus());

    response = Unirest.get(url).asString();
    assertEquals(401, response.getStatus());
  }
}

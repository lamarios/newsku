package com.github.lamarios.newsku.security;

import static org.junit.jupiter.api.Assertions.*;

import com.github.lamarios.newsku.TestConfig;
import com.github.lamarios.newsku.TestContainerTest;
import com.github.lamarios.newsku.controllers.UserController;
import com.github.lamarios.newsku.persistence.repositories.ApiKeyRepository;
import com.github.lamarios.newsku.services.EmailService;
import com.github.lamarios.newsku.services.UserService;
import com.github.lamarios.newsku.utils.MockEmailService;
import com.github.lamarios.newsku.utils.TestUserService;
import kong.unirest.core.HttpResponse;
import kong.unirest.core.Unirest;
import kong.unirest.core.json.JSONObject;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.context.annotation.Import;

/** Goes through real HTTP requests so the authentication filter is exercised */
@Import(TestConfig.class)
public class SessionSecurityTest extends TestContainerTest {
  @LocalServerPort private int port;
  @Autowired private UserService userService;
  @Autowired private EmailService emailService;
  @Autowired private ApiKeyRepository apiKeyRepository;

  @BeforeEach
  public void useHttpAuthentication() {
    // the current user comes from the request authentication instead of being forced
    ((TestUserService) userService).setCurrentUser(null);
    ((MockEmailService) emailService).getEmails().clear();
  }

  @AfterEach
  public void tearDown() {
    apiKeyRepository.deleteAll();
  }

  private String url(String path) {
    return "http://localhost:" + port + path;
  }

  private String login(String password) {
    var response =
        Unirest.post(url("/login"))
            .header("Content-Type", "application/json")
            .body(new JSONObject().put("username", "test").put("password", password).toString())
            .asString();
    assertEquals(200, response.getStatus());
    return response.getBody();
  }

  private int getUserStatus(String authorization) {
    return Unirest.get(url("/api/users"))
        .header("Authorization", authorization)
        .asString()
        .getStatus();
  }

  private HttpResponse<String> changePassword(String authorization, String password) {
    var user =
        new JSONObject(
            Unirest.get(url("/api/users"))
                .header("Authorization", authorization)
                .asString()
                .getBody());
    user.put("password", password);
    return Unirest.post(url("/api/users"))
        .header("Authorization", authorization)
        .header("Content-Type", "application/json")
        .body(user.toString())
        .asString();
  }

  private String createApiKey(String authorization) {
    var response =
        Unirest.put(url("/api/api-keys"))
            .header("Authorization", authorization)
            .header("Content-Type", "application/json")
            .body("{\"name\": \"key\"}")
            .asString();
    assertEquals(200, response.getStatus());
    return new JSONObject(response.getBody()).getString("key");
  }

  @Test
  public void passwordChangeLogsOutOtherSessionsButKeepsCaller() {
    String deviceA = "Bearer " + login("test");
    String deviceB = "Bearer " + login("test");
    String apiKey = createApiKey(deviceA);

    var response = changePassword(deviceA, "new password");
    assertEquals(200, response.getStatus());
    String newToken = response.getHeaders().getFirst(UserController.NEW_TOKEN_HEADER);
    assertNotNull(newToken);
    assertFalse(newToken.isBlank());

    // both old sessions are logged out, the caller continues with the new token
    assertEquals(401, getUserStatus(deviceA));
    assertEquals(401, getUserStatus(deviceB));
    assertEquals(200, getUserStatus("Bearer " + newToken));

    // API keys are not affected by password changes
    assertEquals(200, getUserStatus(apiKey));

    // updating something else doesn't change the token
    response = changePassword("Bearer " + newToken, "");
    assertEquals(200, response.getStatus());
    assertTrue(response.getHeaders().get(UserController.NEW_TOKEN_HEADER).isEmpty());
    assertEquals(200, getUserStatus("Bearer " + newToken));

    login("new password");
  }

  @Test
  public void apiKeysCantManageTheAccount() {
    String session = "Bearer " + login("test");
    String apiKey = createApiKey(session);

    // reading works
    assertEquals(200, getUserStatus(apiKey));

    // but no credential changes or new keys
    assertEquals(403, changePassword(apiKey, "hijacked").getStatus());
    assertEquals(
        403,
        Unirest.put(url("/api/api-keys"))
            .header("Authorization", apiKey)
            .header("Content-Type", "application/json")
            .body("{\"name\": \"persistence\"}")
            .asString()
            .getStatus());
    assertEquals(
        403,
        Unirest.put(url("/api/users/oidc"))
            .header("Authorization", apiKey)
            .body("some token")
            .asString()
            .getStatus());

    login("test");
  }

  @Test
  public void resetPasswordLinksAreSingleUseAndSeparateFromSessions() {
    String session = "Bearer " + login("test");

    // a session token can't reset a password
    assertEquals(
        400,
        Unirest.post(url("/reset-password"))
            .queryString("token", session.substring(7))
            .body("hijacked")
            .asString()
            .getStatus());

    assertEquals(
        200, Unirest.post(url("/forgot-password")).body("test@test.com").asString().getStatus());
    var emails = ((MockEmailService) emailService).getEmails();
    assertEquals(1, emails.size());
    String link = (String) emails.poll().data().get("url");
    String resetToken = link.substring(link.indexOf("token=") + 6);

    // a reset token can't be used as a session
    assertEquals(401, getUserStatus("Bearer " + resetToken));

    // empty passwords are refused
    assertEquals(
        400,
        Unirest.post(url("/reset-password"))
            .queryString("token", resetToken)
            .body(" ")
            .asString()
            .getStatus());

    assertEquals(
        200,
        Unirest.post(url("/reset-password"))
            .queryString("token", resetToken)
            .body("reset password")
            .asString()
            .getStatus());

    // the link only works once and the reset logged out the existing session
    assertEquals(
        400,
        Unirest.post(url("/reset-password"))
            .queryString("token", resetToken)
            .body("again")
            .asString()
            .getStatus());
    assertEquals(401, getUserStatus(session));

    login("reset password");
  }
}

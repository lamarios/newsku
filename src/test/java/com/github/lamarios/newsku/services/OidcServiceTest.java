package com.github.lamarios.newsku.services;

import static org.junit.jupiter.api.Assertions.*;

import com.github.lamarios.newsku.TestConfig;
import com.github.lamarios.newsku.TestContainerTest;
import com.github.lamarios.newsku.controllers.UserController;
import com.github.lamarios.newsku.errors.NewskuUserException;
import com.github.lamarios.newsku.models.ReadItemHandling;
import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.security.JwtAuthenticationController;
import com.github.lamarios.newsku.security.JwtTokenUtil;
import com.github.lamarios.newsku.utils.TestUserService;
import io.jsonwebtoken.Jwts;
import java.security.KeyPair;
import java.util.Date;
import kong.unirest.core.json.JSONObject;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Import;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.test.util.ReflectionTestUtils;

@Import(TestConfig.class)
public class OidcServiceTest extends TestContainerTest {
  private static final String CLIENT_ID = "newsku";
  private static final KeyPair PROVIDER_KEYS = Jwts.SIG.RS256.keyPair().build();
  private static final KeyPair OTHER_KEYS = Jwts.SIG.RS256.keyPair().build();

  @Autowired private OidcService oidcService;
  @Autowired private UserService userService;
  @Autowired private UserController userController;
  @Autowired private JwtAuthenticationController authenticationController;
  @Autowired private JwtTokenUtil jwtTokenUtil;

  @BeforeEach
  public void setupOidc() {
    ReflectionTestUtils.setField(oidcService, "clientId", CLIENT_ID);
    oidcService.setParser(Jwts.parser().verifyWith(PROVIDER_KEYS.getPublic()).build());
  }

  @AfterEach
  public void resetOidcSettings() {
    ReflectionTestUtils.setField(oidcService, "clientId", "");
    ReflectionTestUtils.setField(oidcService, "autoSignUpUsers", false);
    oidcService.setParser(null);
  }

  private static String providerToken(String sub, String audience, KeyPair keys) {
    return Jwts.builder()
        .subject(sub)
        .audience()
        .add(audience)
        .and()
        .expiration(new Date(System.currentTimeMillis() + 60_000))
        .signWith(keys.getPrivate())
        .compact();
  }

  @Test
  public void tokenMustBeIssuedForOurClient() {
    oidcService.checkTokenClient(Jwts.claims().audience().add(CLIENT_ID).and().build());
    oidcService.checkTokenClient(
        Jwts.claims().audience().add("account").and().add("azp", CLIENT_ID).build());

    assertThrows(
        BadCredentialsException.class,
        () ->
            oidcService.checkTokenClient(
                Jwts.claims().audience().add("other-app").and().add("azp", "other-app").build()));
    assertThrows(
        BadCredentialsException.class,
        () -> oidcService.checkTokenClient(Jwts.claims().subject("someone").build()));
  }

  @Test
  public void neverLinksExistingUserOnLogin() {
    var existing = userService.getUser("test").orElseThrow();

    // even with the same username and a verified email, linking must be done from the settings
    var info =
        new JSONObject()
            .put("sub", "some-sub")
            .put("preferred_username", "test")
            .put("email", existing.getEmail())
            .put("email_verified", true);
    assertThrows(NewskuUserException.class, () -> oidcService.linkOrCreateUser("some-sub", info));

    ReflectionTestUtils.setField(oidcService, "autoSignUpUsers", true);
    assertThrows(NewskuUserException.class, () -> oidcService.linkOrCreateUser("some-sub", info));

    assertTrue(userService.getByOidcSub("some-sub").isEmpty());
  }

  @Test
  public void userInfoMustMatchTokenSubject() {
    ReflectionTestUtils.setField(oidcService, "autoSignUpUsers", true);
    var info =
        new JSONObject()
            .put("sub", "someone-else")
            .put("preferred_username", "newuser")
            .put("email", "newuser@test.com");
    assertThrows(
        BadCredentialsException.class, () -> oidcService.linkOrCreateUser("new-sub", info));
  }

  @Test
  public void createsUserOnlyWhenAutoSignupEnabled() throws Exception {
    var info =
        new JSONObject()
            .put("sub", "new-sub")
            .put("preferred_username", "newuser")
            .put("email", "newuser@test.com");

    assertThrows(NewskuUserException.class, () -> oidcService.linkOrCreateUser("new-sub", info));

    ReflectionTestUtils.setField(oidcService, "autoSignUpUsers", true);
    User created = oidcService.linkOrCreateUser("new-sub", info).orElseThrow();
    assertEquals("newuser", created.getUsername());
    assertEquals("new-sub", created.getOidcSub());
    assertEquals(ReadItemHandling.none, created.getReadItemHandling());
  }

  @Test
  public void autoSignupRequiresAnEmail() {
    ReflectionTestUtils.setField(oidcService, "autoSignUpUsers", true);

    var noEmail = new JSONObject().put("sub", "new-sub").put("preferred_username", "newuser");
    var nullEmail =
        new JSONObject()
            .put("sub", "new-sub")
            .put("preferred_username", "newuser")
            .put("email", JSONObject.NULL);
    var blankEmail =
        new JSONObject()
            .put("sub", "new-sub")
            .put("preferred_username", "newuser")
            .put("email", " ");

    for (var info : java.util.List.of(noEmail, nullEmail, blankEmail)) {
      var e =
          assertThrows(
              NewskuUserException.class, () -> oidcService.linkOrCreateUser("new-sub", info));
      assertTrue(e.getMessage().contains("no email address"));
    }
    assertTrue(userService.getByOidcSub("new-sub").isEmpty());
  }

  @Test
  public void linkFromSettingsThenLogin() throws Exception {
    var current = userController.getCurrentUser();

    var linked = userController.linkOidc(providerToken("my-sub", CLIENT_ID, PROVIDER_KEYS));
    assertEquals("my-sub", linked.getOidcSub());
    assertEquals(current.getId(), userService.getByOidcSub("my-sub").orElseThrow().getId());

    // the linked account can now log in with OIDC
    var token =
        authenticationController.loginWithOidcToken(
            "Bearer " + providerToken("my-sub", CLIENT_ID, PROVIDER_KEYS));
    assertEquals(current.getUsername(), jwtTokenUtil.getUsernameFromToken(token));

    var unlinked = userController.unlinkOidc();
    assertNull(unlinked.getOidcSub());
    assertTrue(userService.getByOidcSub("my-sub").isEmpty());
  }

  @Test
  public void cantLinkWithInvalidToken() {
    // signed by someone else
    assertThrows(
        NewskuUserException.class,
        () -> userController.linkOidc(providerToken("my-sub", CLIENT_ID, OTHER_KEYS)));
    // issued for another application
    assertThrows(
        NewskuUserException.class,
        () -> userController.linkOidc(providerToken("my-sub", "other-app", PROVIDER_KEYS)));
    assertThrows(NewskuUserException.class, () -> userController.linkOidc("garbage"));

    assertNull(userController.getCurrentUser().getOidcSub());
  }

  @Test
  public void cantLinkOidcAccountOfAnotherUser() throws Exception {
    var testUser = userService.getCurrentUser();

    var other = new User();
    other.setUsername("other");
    other.setPassword("other");
    other.setEmail("other@test.com");
    other.setReadItemHandling(ReadItemHandling.none);
    other = userService.createUser(other);

    ((TestUserService) userService).setCurrentUser(other);
    userController.linkOidc(providerToken("other-sub", CLIENT_ID, PROVIDER_KEYS));

    ((TestUserService) userService).setCurrentUser(testUser);
    assertThrows(
        NewskuUserException.class,
        () -> userController.linkOidc(providerToken("other-sub", CLIENT_ID, PROVIDER_KEYS)));

    assertEquals(other.getId(), userService.getByOidcSub("other-sub").orElseThrow().getId());
  }
}

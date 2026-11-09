package com.github.lamarios.newsku.controllers;

import com.github.lamarios.newsku.errors.NewskuUserException;
import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.security.JwtTokenUtil;
import com.github.lamarios.newsku.services.OidcService;
import com.github.lamarios.newsku.services.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
@Tag(name = "Users")
@SecurityRequirement(name = "bearerAuth")
@SecurityRequirement(name = "apiKey")
public class UserController {
  public static final String NEW_TOKEN_HEADER = "X-New-Token";
  private final boolean demoMode;
  private final UserService userService;
  private final OidcService oidcService;
  private final JwtTokenUtil jwtTokenUtil;

  @Autowired
  public UserController(
      UserService userService,
      OidcService oidcService,
      JwtTokenUtil jwtTokenUtil,
      @Value("${DEMO_MODE:0}") boolean demoMode) {
    this.userService = userService;
    this.oidcService = oidcService;
    this.jwtTokenUtil = jwtTokenUtil;
    this.demoMode = demoMode;
  }

  @PostMapping
  @Operation(
      description =
          "Updates the current user. Changing the password logs out every session, a new token for"
              + " the caller is returned in the "
              + NEW_TOKEN_HEADER
              + " header")
  public ResponseEntity<User> updateUser(@RequestBody User user) throws NewskuUserException {
    if (demoMode) {
      throw new AccessDeniedException("App in demoMode");
    }
    // values are copied as the entity is updated in place within the request
    var before = userService.getCurrentUser();
    int tokenVersionBefore = before.getTokenVersion();
    String usernameBefore = before.getUsername();

    var updated = userService.updateSelf(user);

    // the token of the caller is invalid now if the password or the username changed
    if (updated.getTokenVersion() != tokenVersionBefore
        || !updated.getUsername().equals(usernameBefore)) {
      var token =
          jwtTokenUtil.generateToken(
              new org.springframework.security.core.userdetails.User(
                  updated.getUsername(), updated.getPassword(), List.of()));
      return ResponseEntity.ok().header(NEW_TOKEN_HEADER, token).body(updated);
    }

    return ResponseEntity.ok(updated);
  }

  @GetMapping
  public User getCurrentUser() {
    return userService.getCurrentUser();
  }

  @PutMapping("/oidc")
  @Operation(
      description =
          "Links an SSO account to the current user. The body is an access token from the OIDC"
              + " provider")
  public User linkOidc(@RequestBody String accessToken) throws NewskuUserException {
    if (demoMode) {
      throw new AccessDeniedException("App in demoMode");
    }
    userService.requireLoginSession();
    return oidcService.linkCurrentUser(accessToken.trim());
  }

  @DeleteMapping("/oidc")
  public User unlinkOidc() {
    if (demoMode) {
      throw new AccessDeniedException("App in demoMode");
    }
    userService.requireLoginSession();
    return oidcService.unlinkCurrentUser();
  }
}

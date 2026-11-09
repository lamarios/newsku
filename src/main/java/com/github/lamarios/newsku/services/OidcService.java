package com.github.lamarios.newsku.services;

import static java.util.stream.Collectors.toMap;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.lamarios.newsku.errors.NewskuUserException;
import com.github.lamarios.newsku.models.OIDCConfig;
import com.github.lamarios.newsku.models.ReadItemHandling;
import com.github.lamarios.newsku.persistence.entities.User;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Identifiable;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.JwtParser;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Jwk;
import io.jsonwebtoken.security.Jwks;
import java.util.Optional;
import kong.unirest.core.GetRequest;
import kong.unirest.core.Unirest;
import kong.unirest.core.UnirestException;
import kong.unirest.core.json.JSONObject;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class OidcService implements ApplicationContextAware {
  @Value("${OIDC_DISCOVERY_URL:}")
  private String oidcDiscoveryUrl;

  @Value("${OIDC_AUTO_SIGNUP_USERS:0}")
  private boolean autoSignUpUsers;

  @Value("${OIDC_CLIENT_ID:}")
  private String clientId;

  @Value("${OIDC_EMAIL_CLAIM:email}")
  private String oidcEmailClaim;

  @Value("${OIDC_USERNAME_CLAIM:preferred_username}")
  private String oidcPreferredUsernameClaim;

  @Value("${OIDC_NAME:SSO}")
  private String oidcName;

  private JwtParser parser;
  private OIDCConfig oidcConfig;
  private final ObjectMapper objectMapper = new ObjectMapper();
  private final UserService userService;

  @Autowired
  public OidcService(UserService userService) {
    this.userService = userService;
    objectMapper.disable(
        DeserializationFeature.FAIL_ON_IGNORED_PROPERTIES,
        DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
  }

  public String getOidcDiscoveryUrl() {
    return oidcDiscoveryUrl;
  }

  public OIDCConfig getOidcConfig() {
    return oidcConfig;
  }

  @Override
  public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
    if (oidcDiscoveryUrl != null && !oidcDiscoveryUrl.isBlank()) {
      GetRequest request = Unirest.get(oidcDiscoveryUrl);
      try {
        var body = request.asString();

        String bodyStr = body.getBody();
        oidcConfig = objectMapper.readValue(bodyStr, OIDCConfig.class);

        request = Unirest.get(oidcConfig.getJwksUri());
        bodyStr = request.asString().getBody();

        oidcConfig.setDiscoveryUrl(oidcDiscoveryUrl);
        oidcConfig.setClientId(clientId);
        oidcConfig.setEmailClaim(oidcEmailClaim);
        oidcConfig.setUsernameClaim(oidcPreferredUsernameClaim);
        oidcConfig.setName(oidcName);

        var keyMap =
            Jwks.setParser().build().parse(bodyStr).getKeys().stream()
                .collect(toMap(Identifiable::getId, Jwk::toKey));

        var parserBuilder =
            Jwts.parser()
                .keyLocator(header -> keyMap.get(header.getOrDefault("kid", "").toString()));
        if (oidcConfig.getIssuer() != null && !oidcConfig.getIssuer().isBlank()) {
          parserBuilder = parserBuilder.requireIssuer(oidcConfig.getIssuer());
        }
        parser = parserBuilder.build();
      } catch (UnirestException | JsonProcessingException e) {
        throw new RuntimeException(e);
      }
    }
  }

  public JwtParser getParser() {
    return parser;
  }

  public void setParser(JwtParser parser) {
    this.parser = parser;
  }

  public String getOidcEmailClaim() {
    return oidcEmailClaim;
  }

  /**
   * Parses and validates a token from the OIDC provider. On top of the signature and issuer checks
   * done by the parser, the token must have been issued for our client, either as its audience or
   * as its authorized party (azp) as some providers put the API in the audience of access tokens.
   * Without this check, a token issued by the same provider for any other application would be
   * accepted.
   */
  public Claims parseToken(String token) {
    Claims claims = parser.parseSignedClaims(token).getPayload();
    checkTokenClient(claims);
    return claims;
  }

  void checkTokenClient(Claims claims) {
    if (clientId == null || clientId.isBlank()) {
      return;
    }

    boolean inAudience = claims.getAudience() != null && claims.getAudience().contains(clientId);
    boolean authorizedParty = clientId.equals(claims.get("azp", String.class));
    if (!inAudience && !authorizedParty) {
      throw new BadCredentialsException("OIDC token was not issued for this client");
    }
  }

  public Optional<User> handleUserSub(String sub, String accessToken) throws Exception {
    // check DB if we have a user with this sub
    var userOpt = userService.getByOidcSub(sub);
    if (userOpt.isPresent()) {
      return userOpt;
    }

    GetRequest request =
        Unirest.get(oidcConfig.getUserInfoUrl()).header("Authorization", "Bearer " + accessToken);
    JSONObject userInfo = request.asJson().getBody().getObject();

    return linkOrCreateUser(sub, userInfo);
  }

  /**
   * Finds the user for an OIDC subject that isn't linked to any account yet. It never links to an
   * existing account: local accounts aren't verified, so anyone could sign up with someone else's
   * username and email before that person's first OIDC login and get linked to them. Existing users
   * link their OIDC account from the settings with {@link #linkCurrentUser(String)} instead. A new
   * account is created if auto sign up is enabled.
   */
  Optional<User> linkOrCreateUser(String sub, JSONObject userInfo) throws Exception {
    // the user info must be about the user of the token
    if (!userInfo.has("sub") || !sub.equals(userInfo.getString("sub"))) {
      throw new BadCredentialsException("OIDC user info subject doesn't match the token");
    }

    if (!userInfo.has(oidcPreferredUsernameClaim)) {
      throw new BadCredentialsException("OIDC user info has no username");
    }

    if (!autoSignUpUsers) {
      throw new NewskuUserException(
          "No account is linked to this SSO account. Log in with your password and link it from"
              + " the settings");
    }

    // an email is required for every account, the provider might not send one (no email set,
    // scope not allowed for the client, different claim name...)
    String email =
        userInfo.has(oidcEmailClaim) && !userInfo.isNull(oidcEmailClaim)
            ? userInfo.getString(oidcEmailClaim).trim()
            : "";
    if (email.isBlank()) {
      throw new NewskuUserException(
          "Your SSO account has no email address, which is required to create an account");
    }

    String username = userInfo.getString(oidcPreferredUsernameClaim);
    if (userService.getUser(username).isPresent()) {
      throw new NewskuUserException(
          "An account with this username already exists. Log in with your password and link your"
              + " SSO account from the settings");
    }

    var user = new User();
    user.setOidcSub(sub);
    user.setPassword(RandomStringUtils.secure().nextAlphabetic(70));
    user.setEmail(email);
    user.setUsername(username);
    user.setReadItemHandling(ReadItemHandling.none);

    return Optional.ofNullable(userService.createUser(user));
  }

  /**
   * Links the OIDC account of the given token to the current user. Being logged in proves the
   * ownership of the local account and the token proves the ownership of the OIDC account.
   */
  @Transactional
  public User linkCurrentUser(String token) throws NewskuUserException {
    if (parser == null) {
      throw new NewskuUserException("SSO is not configured");
    }

    String sub;
    try {
      sub = parseToken(token).getSubject();
    } catch (JwtException | BadCredentialsException e) {
      throw new NewskuUserException("Invalid SSO token");
    }

    if (sub == null || sub.isBlank()) {
      throw new NewskuUserException("Invalid SSO token");
    }

    var user = userService.getCurrentUser();
    var linkedUser = userService.getByOidcSub(sub);
    if (linkedUser.isPresent() && !linkedUser.get().getId().equals(user.getId())) {
      throw new NewskuUserException("This SSO account is already linked to another user");
    }

    user.setOidcSub(sub);
    return userService.updateUser(user);
  }

  @Transactional
  public User unlinkCurrentUser() {
    var user = userService.getCurrentUser();
    user.setOidcSub(null);
    return userService.updateUser(user);
  }
}

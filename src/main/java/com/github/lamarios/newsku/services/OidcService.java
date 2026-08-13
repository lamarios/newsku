package com.github.lamarios.newsku.services;

import static java.util.stream.Collectors.toMap;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.lamarios.newsku.models.OIDCConfig;
import com.github.lamarios.newsku.persistence.entities.User;
import io.jsonwebtoken.Identifiable;
import io.jsonwebtoken.JwtParser;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Jwk;
import io.jsonwebtoken.security.Jwks;
import java.nio.charset.StandardCharsets;
import java.util.Optional;
import java.util.Random;
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
import org.springframework.stereotype.Service;

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

        parser =
            Jwts.parser()
                .keyLocator(header -> keyMap.get(header.getOrDefault("kid", "").toString()))
                .build();
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

  public Optional<User> handleUserSub(String sub, String accessToken) throws Exception {
    // check DB if we have a user with this sub
    var userOpt = userService.getByOidcSub(sub);
    // if we don't get the info
    if (userOpt.isEmpty()) {
      GetRequest request =
          Unirest.get(oidcConfig.getUserInfoUrl()).header("Authorization", "Bearer " + accessToken);
      var body = request.asJson().getBody();

      JSONObject object = body.getObject();
      if (object.has(oidcPreferredUsernameClaim)) {
        var user = userService.getUser(object.getString(oidcPreferredUsernameClaim)).orElse(null);
        // if we still don't have  auser we might need to sign it up
        if (user != null) {
          user.setOidcSub(sub);
          return Optional.ofNullable(userService.updateUser(user));
        } else if (autoSignUpUsers) {
          // length is bounded by 7
          byte[] array = new byte[50];
          new Random().nextBytes(array);
          String generatedString = new String(array, StandardCharsets.UTF_8);

          user = new User();
          user.setOidcSub(sub);
          user.setPassword(RandomStringUtils.secure().nextAlphabetic(70));
          user.setEmail(object.getString(oidcEmailClaim));
          user.setUsername(object.getString(oidcPreferredUsernameClaim));

          return Optional.ofNullable(userService.createUser(user));
        } else {
          throw new Exception();
        }
      } else {
        throw new Exception();
      }
    } else {
      return userOpt;
    }
  }
}

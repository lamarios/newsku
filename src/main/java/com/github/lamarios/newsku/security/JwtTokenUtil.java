package com.github.lamarios.newsku.security;

import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.services.UserService;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

@Component
public class JwtTokenUtil {
  private final SecretKey key;
  public static final long JWT_TOKEN_VALIDITY = 90 * 24 * 60 * 60;
  private static final long serialVersionUID = -2550185165626007488L;
  private final String salt;
  //    private final OIDCService oidcService;
  private final UserService userService;

  @Autowired
  public JwtTokenUtil(UserService userService, @Value("${SALT}") String salt) throws Exception {
    //        this.oidcService = oidcService;
    this.userService = userService;
    this.salt = salt;

    this.key = deriveKey(salt);
  }

  private static SecretKey deriveKey(String salt) throws Exception {
    // If shorter than 64 bytes, repeat until length ≥ 64
    byte[] saltBytes = salt.getBytes();
    if (saltBytes.length < 64) {
      byte[] extended = new byte[64];
      for (int i = 0; i < 64; i++) {
        extended[i] = saltBytes[i % saltBytes.length];
      }
      saltBytes = extended;
    } else if (saltBytes.length > 64) {
      // Truncate to 64 bytes if longer
      saltBytes = Arrays.copyOf(saltBytes, 64);
    }

    return new SecretKeySpec(saltBytes, "HmacSHA512");
  }

  public String getUsernameFromToken(String token) {
    return getClaimFromToken(token, Claims::getSubject);
  }

  public Date getIssuedAtDateFromToken(String token) {
    return getClaimFromToken(token, Claims::getIssuedAt);
  }

  public Date getExpirationDateFromToken(String token) {
    return getClaimFromToken(token, Claims::getExpiration);
  }

  public <T> T getClaimFromToken(String token, Function<Claims, T> claimsResolver) {
    final Claims claims = getAllClaimsFromToken(token);
    return claimsResolver.apply(claims);
  }

  public Claims getAllClaimsFromToken(String token) {
    try {
      return Jwts.parser().verifyWith(key).build().parseSignedClaims(token).getPayload();
    } catch (Exception e) {
      /*
                  if (oidcService.getParser() != null) {
                      return oidcService.getParser().parseSignedClaims(token).getPayload();
                  } else {
      */
      throw e;
      //            }
    }
  }

  private Boolean isTokenExpired(String token) {
    final Date expiration = getExpirationDateFromToken(token);
    return expiration.before(new Date());
  }

  private Boolean ignoreTokenExpiration(String token) {
    // here you specify tokens, for that the expiration is ignored
    return false;
  }

  public String generateToken(UserDetails userDetails) {
    try {
      User user = userService.getUser(userDetails.getUsername()).orElseThrow();
      Map<String, Object> userClaim = new HashMap<>();
      userClaim.put("id", user.getId().toString());
      userClaim.put("username", user.getUsername());
      userClaim.put("email", user.getEmail());

      Map<String, Object> claims = new HashMap<>();
      claims.put("user", userClaim);
      return doGenerateToken(claims, userDetails.getUsername());
    } catch (Exception e) {
      e.printStackTrace();
      return null;
    }
  }

  public String doGenerateToken(Map<String, Object> claims, String subject) {
    return doGenerateToken(claims, subject, JWT_TOKEN_VALIDITY * 1000);
  }

  public String doGenerateToken(Map<String, Object> claims, String subject, long expiresIn) {
    return Jwts.builder()
        .claims(claims)
        .subject(subject)
        .issuedAt(new Date(System.currentTimeMillis()))
        .issuer("newsku")
        .expiration(new Date(System.currentTimeMillis() + expiresIn))
        .signWith(key)
        .compact();
  }

  public Boolean canTokenBeRefreshed(String token) {
    return (!isTokenExpired(token) || ignoreTokenExpiration(token));
  }

  public Boolean validateToken(String token, UserDetails userDetails) {
    final String username = getUsernameFromToken(token);
    var user = userService.getUser(userDetails.getUsername());
    return ((username.equals(userDetails.getUsername())) && !isTokenExpired(token));
  }

  public String getSalt() {
    return salt;
  }
}

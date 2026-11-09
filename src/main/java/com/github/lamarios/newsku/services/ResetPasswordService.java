package com.github.lamarios.newsku.services;

import com.github.lamarios.newsku.errors.NewskuUserException;
import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.persistence.repositories.UserRepository;
import com.github.lamarios.newsku.security.JwtTokenUtil;
import freemarker.template.TemplateException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ResetPasswordService {
  public static final int RESET_PASSOWRD_EXPIRY = 24 * 60 * 60 * 1000;
  private final UserRepository userRepository;
  private final JwtTokenUtil jwtTokenUtil;
  private final String rootUrl;
  private final EmailService emailService;
  private final PasswordEncoder passwordEncoder;

  @Autowired
  public ResetPasswordService(
      UserRepository userRepository,
      JwtTokenUtil jwtTokenUtil,
      String rootUrl,
      EmailService emailService,
      PasswordEncoder passwordEncoder) {
    this.userRepository = userRepository;
    this.jwtTokenUtil = jwtTokenUtil;
    this.rootUrl = rootUrl;
    this.emailService = emailService;
    this.passwordEncoder = passwordEncoder;
  }

  @Transactional(readOnly = true)
  public void forgotPassword(String email) throws TemplateException, IOException {
    User user = userRepository.findFirstByEmail(email);

    if (user == null) {
      return;
    }

    String token =
        jwtTokenUtil.doGenerateToken(
            Map.of(
                JwtTokenUtil.TYPE_CLAIM,
                JwtTokenUtil.RESET_PASSWORD_TYPE,
                // the reset increases the version, which makes the link single use
                JwtTokenUtil.VERSION_CLAIM,
                user.getTokenVersion(),
                "request-id",
                UUID.randomUUID().toString(),
                "server-url",
                rootUrl),
            user.getId(),
            RESET_PASSOWRD_EXPIRY);

    Map<String, Object> templateData = new HashMap<>();

    String resetPasswordUrl = rootUrl + "/#/reset-password?token=" + token;
    templateData.put("url", resetPasswordUrl);
    templateData.put("username", user.getUsername());

    emailService.sendTemplate(
        user.getEmail(),
        "[Newsku] Reset password request",
        "email/reset-password.ftl",
        templateData);
  }

  @Transactional
  public void resetPassword(String token, String password) throws NewskuUserException {
    if (password == null || password.isBlank()) {
      throw new NewskuUserException("Password is empty");
    }

    Claims claims;
    try {
      claims = jwtTokenUtil.getAllClaimsFromToken(token);
    } catch (JwtException | IllegalArgumentException e) {
      throw new NewskuUserException("Invalid or expired link");
    }

    // login tokens must not be usable to reset a password
    if (!JwtTokenUtil.RESET_PASSWORD_TYPE.equals(
        claims.get(JwtTokenUtil.TYPE_CLAIM, String.class))) {
      throw new NewskuUserException("Invalid or expired link");
    }

    User user = userRepository.findFirstById(claims.getSubject());
    if (user == null || JwtTokenUtil.getTokenVersion(claims) != user.getTokenVersion()) {
      throw new NewskuUserException("Invalid or expired link");
    }

    user.setPassword(passwordEncoder.encode(password));
    // logs out every session and invalidates other reset links
    user.setTokenVersion(user.getTokenVersion() + 1);

    userRepository.save(user);
  }
}

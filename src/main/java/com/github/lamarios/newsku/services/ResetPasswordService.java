package com.github.lamarios.newsku.services;

import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.persistence.repositories.UserRepository;
import com.github.lamarios.newsku.security.JwtTokenUtil;
import freemarker.template.TemplateException;
import io.jsonwebtoken.security.SignatureException;
import java.io.IOException;
import java.security.InvalidParameterException;
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
                "type",
                "reset-password",
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
  public void resetPassword(String token, String password) {
    try {
      var claims = jwtTokenUtil.getAllClaimsFromToken(token);
      User user = userRepository.findFirstById(claims.getSubject());

      if (user == null) {
        throw new InvalidParameterException("Invalid token");
      }

      user.setPassword(passwordEncoder.encode(password));

      userRepository.save(user);
    } catch (SignatureException e) {
      throw new InvalidParameterException("Invalid token");
    }
  }
}

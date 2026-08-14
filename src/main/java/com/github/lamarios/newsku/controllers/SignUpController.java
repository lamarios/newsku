package com.github.lamarios.newsku.controllers;

import com.github.lamarios.newsku.errors.NewskuUserException;
import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.services.UserService;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/signup")
@Tag(name = "Log in")
public class SignUpController {
  private final UserService userService;
  private final boolean allowSignUp;
  private final boolean demoMode;

  @Autowired
  public SignUpController(
      UserService userService,
      @Value("${ALLOW_SIGNUP:0}") boolean allowSignUp,
      @Value("${DEMO_MODE:0}") boolean demoMode) {
    this.userService = userService;
    this.allowSignUp = allowSignUp;
    this.demoMode = demoMode;
  }

  @PutMapping
  public User signup(@RequestBody User user)
      throws java.nio.file.AccessDeniedException, NewskuUserException {
    if (demoMode) {
      throw new AccessDeniedException("App in demoMode");
    }
    if (allowSignUp) {
      return userService.createUser(user);
    } else {
      throw new AccessDeniedException("Sign up not allowed");
    }
  }
}

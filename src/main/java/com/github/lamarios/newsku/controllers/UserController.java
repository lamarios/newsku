package com.github.lamarios.newsku.controllers;

import com.github.lamarios.newsku.errors.NewskuUserException;
import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.services.UserService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
@Tag(name = "Users")
@SecurityRequirement(name = "bearerAuth")
public class UserController {
  private final boolean demoMode;
  private final UserService userService;

  @Autowired
  public UserController(UserService userService, @Value("${DEMO_MODE:0}") boolean demoMode) {
    this.userService = userService;
    this.demoMode = demoMode;
  }

  @PostMapping
  public User updateUser(@RequestBody User user) throws NewskuUserException {
    if (demoMode) {
      throw new AccessDeniedException("App in demoMode");
    }
    return userService.updateSelf(user);
  }

  @GetMapping
  public User getCurrentUser() {
    return userService.getCurrentUser();
  }
}

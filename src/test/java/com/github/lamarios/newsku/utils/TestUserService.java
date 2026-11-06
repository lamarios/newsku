package com.github.lamarios.newsku.utils;

import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.persistence.repositories.UserRepository;
import com.github.lamarios.newsku.services.UserService;
import org.springframework.security.crypto.password.PasswordEncoder;

public class TestUserService extends UserService {
  private User currentUser;

  public TestUserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
    super(userRepository, passwordEncoder);
  }

  /**
   * Returns the user set with {@link #setCurrentUser(User)}, or the authenticated user from the
   * security context when none is set (for tests going through real HTTP authentication)
   */
  @Override
  public User getCurrentUser() {
    return currentUser != null ? currentUser : super.getCurrentUser();
  }

  public void setCurrentUser(User currentUser) {
    this.currentUser = currentUser;
  }
}

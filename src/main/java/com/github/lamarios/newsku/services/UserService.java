package com.github.lamarios.newsku.services;

import com.github.lamarios.newsku.errors.NewskuUserException;
import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.persistence.repositories.UserRepository;
import java.util.Objects;
import java.util.Optional;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserService {
  private final UserRepository userRepository;
  private final PasswordEncoder passwordEncoder;
  private static final String EMAIL_REGEX =
      "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";

  @Autowired
  public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
    this.userRepository = userRepository;
    this.passwordEncoder = passwordEncoder;
  }

  @Transactional(readOnly = true)
  public Optional<User> getUser(String username) {
    return userRepository.getUserByUsername(username).stream().findFirst();
  }

  @Transactional(readOnly = true)
  public User getCurrentUser() {
    final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

    assert authentication != null;
    org.springframework.security.core.userdetails.User user =
        (org.springframework.security.core.userdetails.User) authentication.getPrincipal();

    assert user != null;
    return getUser(user.getUsername()).orElseThrow();
  }

  @Transactional
  public User createUser(User user) throws NewskuUserException {
    user.setId(UUID.randomUUID().toString());

    boolean emailUsed = userRepository.countUserByEmail(user.getEmail()) > 0;
    boolean usernameUsed = userRepository.countUserByUsername(user.getUsername()) > 0;

    if (emailUsed) {
      try {
        // we sleep to limit email scanning
        Thread.sleep(2000);
      } catch (InterruptedException _) {
      }
      throw new NewskuUserException("Email already taken");
    }

    if (usernameUsed) {
      try {
        // we sleep to limit email scanning
        Thread.sleep(2000);
      } catch (InterruptedException _) {
      }
      throw new NewskuUserException("Username already taken");
    }

    if (!user.getEmail().matches(EMAIL_REGEX)) {
      throw new NewskuUserException("Invalid email address");
    }
    // hash password
    if (user.getPassword() != null) {
      user.setPassword(passwordEncoder.encode(user.getPassword()));
    }

    return userRepository.save(user);
  }

  public Optional<User> getByOidcSub(String sub) {
    return Optional.ofNullable(userRepository.getUserByOidcSub(sub));
  }

  public User updateUser(User user) {
    return userRepository.save(user);
  }

  @Transactional
  public User updateSelf(User user) throws NewskuUserException {
    User currentUser = getCurrentUser();
    if (currentUser.getId().equalsIgnoreCase(user.getId())) {
      // we update the password if it has changed
      if (user.getPassword() != null
          && !user.getPassword().trim().isBlank()
          && !currentUser.getPassword().equalsIgnoreCase(user.getPassword())) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
      } else {
        user.setPassword(currentUser.getPassword());
      }

      if (!Objects.equals(user.getEmail(), currentUser.getEmail())) {
        if (user.getEmail().matches(EMAIL_REGEX)) {
          var alreadyTaken = userRepository.countUserByEmail(user.getEmail()) > 0;
          if (alreadyTaken) {
            throw new NewskuUserException("Email already in use");
          }
        } else {
          throw new NewskuUserException("Invalid email address");
        }
      }

      return updateUser(user);
    } else {
      throw new AccessDeniedException("You can only edit yourself");
    }
  }
}

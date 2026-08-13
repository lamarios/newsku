package com.github.lamarios.newsku.controllers;

import static org.junit.jupiter.api.Assertions.*;

import com.github.lamarios.newsku.TestConfig;
import com.github.lamarios.newsku.TestContainerTest;
import com.github.lamarios.newsku.errors.NewskuUserException;
import com.github.lamarios.newsku.models.ReadItemHandling;
import com.github.lamarios.newsku.persistence.entities.User;
import java.nio.file.AccessDeniedException;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Import;

@Import(TestConfig.class)
public class SignUpControllerTest extends TestContainerTest {
  @Autowired private SignUpController signUpController;

  @Test
  public void signUpTest() throws AccessDeniedException, NewskuUserException {
    User newUser = new User();
    newUser.setPassword("somePassword");
    newUser.setEmail("someemail@eai.com");
    newUser.setUsername("someUsername");
    newUser.setReadItemHandling(ReadItemHandling.none);

    var user = signUpController.signup(newUser);
    assertNotNull(user.getId());
    // password should be hashed
    assertNotEquals("samePassword", user.getPassword());
  }

  @Test
  public void signupValidationTest() {
    // test email already taken
    User newUser = new User();
    newUser.setPassword("somePassword");
    newUser.setEmail("test@test.com");
    newUser.setUsername("testUsername");
    newUser.setReadItemHandling(ReadItemHandling.none);

    var now = System.currentTimeMillis();

    assertThrows(NewskuUserException.class, () -> signUpController.signup(newUser));
    // we make sure we slept at least 2 seconds to avoid email scanning
    assertTrue(System.currentTimeMillis() - now >= 2000);
    // test username already taken
    newUser.setEmail("randomestoff@fdsfsdfsd.com");
    newUser.setUsername("test");

    now = System.currentTimeMillis();
    assertThrows(NewskuUserException.class, () -> signUpController.signup(newUser));

    assertTrue(System.currentTimeMillis() - now >= 2000);
    // test invalid email address
    newUser.setEmail("invalidEmail");
    newUser.setUsername("testUsername");
    assertThrows(NewskuUserException.class, () -> signUpController.signup(newUser));
  }
}

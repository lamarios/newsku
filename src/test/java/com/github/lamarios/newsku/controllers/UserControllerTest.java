package com.github.lamarios.newsku.controllers;

import static org.junit.jupiter.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.github.lamarios.newsku.TestConfig;
import com.github.lamarios.newsku.TestContainerTest;
import com.github.lamarios.newsku.errors.NewskuException;
import com.github.lamarios.newsku.models.ReadItemHandling;
import com.github.lamarios.newsku.models.UserCredentials;
import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.security.JwtAuthenticationController;
import com.github.lamarios.newsku.services.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Import;
import org.springframework.security.access.AccessDeniedException;
import tools.jackson.databind.json.JsonMapper;

@Import(TestConfig.class)
public class UserControllerTest extends TestContainerTest {
  @Autowired private UserController userController;
  @Autowired private JwtAuthenticationController authenticationController;
  @Autowired private UserService userService;
  @Autowired private JsonMapper jsonMapper;

  @Test
  public void testUserUpdateSelf() throws Exception {
    var currentUser = userController.getCurrentUser();
    // because of the test environment set up, we can't just change the id as it will actually
    // update the test current user
    var user = new User();
    user.setId("some id");
    user.setEmail(currentUser.getEmail());
    user.setPassword(currentUser.getPassword());
    user.setUsername(currentUser.getUsername());
    user.setEmailDigest(currentUser.getEmailDigest());
    user.setMinimumImportance(currentUser.getMinimumImportance());
    user.setReadItemHandling(currentUser.getReadItemHandling());
    // we check the validation so that users can only update themselves
    assertThrows(AccessDeniedException.class, () -> userController.updateUser(user));

    user.setId(currentUser.getId());
    // test the current password
    var token = authenticationController.login(new UserCredentials(user.getUsername(), "test"));
    assertTrue(token != null && !token.isEmpty());

    user.setPassword("changed");
    userController.updateUser(user);
    token = authenticationController.login(new UserCredentials(user.getUsername(), "changed"));
    assertTrue(token != null && !token.isEmpty());
    // now we try to change the email
    // first we create a new user
    User conflictingUser = new User();
    conflictingUser.setPassword("aaa");
    conflictingUser.setMinimumImportance(5);
    conflictingUser.setReadItemHandling(ReadItemHandling.dim);
    conflictingUser.setEmail("test2@test.com");
    conflictingUser.setUsername("conflicting user");

    userService.createUser(conflictingUser);
    // we check that we can update ourselves to an existing user
    user.setEmail(conflictingUser.getEmail());
    assertThrows(NewskuException.class, () -> userController.updateUser(user));
    // then we try an email that wasn't used
    user.setEmail("some random email@invalid");
    assertThrows(NewskuException.class, () -> userController.updateUser(user));

    user.setEmail("good.email@email.com");
    var updatedUser = userController.updateUser(user).getBody();

    assertEquals(user.getEmail(), updatedUser.getEmail());
  }

  @Test
  public void testOidcSubCantBeSetByUser() throws Exception {
    var currentUser = userController.getCurrentUser();
    assertNull(currentUser.getOidcSub());

    // the field is ignored when deserializing request bodies
    var fromJson =
        jsonMapper.readValue(
            "{\"id\": \"%s\", \"username\": \"test\", \"email\": \"test@test.com\", \"oidcSub\": \"victim-sub\"}"
                .formatted(currentUser.getId()),
            User.class);
    assertNull(fromJson.getOidcSub());

    // and the service keeps the existing value even if one is passed
    var user = new User();
    user.setId(currentUser.getId());
    user.setUsername(currentUser.getUsername());
    user.setEmail(currentUser.getEmail());
    user.setReadItemHandling(currentUser.getReadItemHandling());
    user.setOidcSub("victim-sub");
    var updated = userController.updateUser(user).getBody();
    assertNull(updated.getOidcSub());
    assertTrue(userService.getByOidcSub("victim-sub").isEmpty());
  }

  @Test
  public void testCantTakeExistingUsername() throws Exception {
    var currentUser = userController.getCurrentUser();

    User other = new User();
    other.setPassword("aaa");
    other.setReadItemHandling(ReadItemHandling.none);
    other.setEmail("other@test.com");
    other.setUsername("other");
    userService.createUser(other);

    var user = new User();
    user.setId(currentUser.getId());
    user.setUsername("other");
    user.setEmail(currentUser.getEmail());
    user.setReadItemHandling(currentUser.getReadItemHandling());
    assertThrows(NewskuException.class, () -> userController.updateUser(user));
  }
}

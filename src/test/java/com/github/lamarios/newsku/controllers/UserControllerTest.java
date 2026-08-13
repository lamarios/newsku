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

@Import(TestConfig.class)
public class UserControllerTest extends TestContainerTest {
    @Autowired
    private UserController userController;
    @Autowired
    private JwtAuthenticationController authenticationController;
    @Autowired
    private UserService userService;

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
        var updatedUser = userController.updateUser(user);

        assertEquals(user.getEmail(), updatedUser.getEmail());
    }
}

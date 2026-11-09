package com.github.lamarios.newsku.controllers;

import static org.junit.jupiter.api.Assertions.*;

import com.github.lamarios.newsku.TestConfig;
import com.github.lamarios.newsku.TestContainerTest;
import com.github.lamarios.newsku.models.LayoutBlockSettings;
import com.github.lamarios.newsku.models.LayoutBlockType;
import com.github.lamarios.newsku.models.ReadItemHandling;
import com.github.lamarios.newsku.persistence.entities.LayoutBlock;
import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.persistence.repositories.LayoutRepository;
import com.github.lamarios.newsku.services.UserService;
import com.github.lamarios.newsku.utils.TestUserService;
import java.util.List;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Import;
import org.springframework.security.access.AccessDeniedException;

@Import(TestConfig.class)
public class LayoutControllerTest extends TestContainerTest {
  @Autowired private LayoutController layoutController;
  @Autowired private FeedCategoryController feedCategoryController;
  @Autowired private UserService userService;
  @Autowired private LayoutRepository layoutRepository;

  @AfterEach
  public void tearDown() {
    layoutRepository.deleteAll();
  }

  private static LayoutBlock block(LayoutBlockType type, String categoryId) {
    var settings = new LayoutBlockSettings();
    settings.setCategoryId(categoryId);
    var block = new LayoutBlock();
    block.setType(type);
    block.setSettings(settings);
    return block;
  }

  @Test
  public void layoutCanOnlyUseOwnCategories() throws Exception {
    var testUser = userService.getCurrentUser();
    var myCategory = feedCategoryController.addCategory("mine");

    var other = new User();
    other.setUsername("other");
    other.setPassword("other");
    other.setEmail("other@test.com");
    other.setReadItemHandling(ReadItemHandling.none);
    other = userService.createUser(other);
    ((TestUserService) userService).setCurrentUser(other);
    var otherCategory = feedCategoryController.addCategory("other's");
    ((TestUserService) userService).setCurrentUser(testUser);

    assertThrows(
        AccessDeniedException.class,
        () ->
            layoutController.setLayout(
                List.of(
                    block(LayoutBlockType.topStories, otherCategory.getId()),
                    block(LayoutBlockType.smallGrid, null))));

    var layout =
        layoutController.setLayout(
            List.of(
                block(LayoutBlockType.topStories, myCategory.getId()),
                block(LayoutBlockType.smallGrid, null)));
    assertEquals(myCategory.getId(), layout.getFirst().getSettings().getCategoryId());
  }
}

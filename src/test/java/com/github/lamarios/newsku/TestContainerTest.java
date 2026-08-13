package com.github.lamarios.newsku;

import com.github.lamarios.newsku.controllers.SignUpController;
import com.github.lamarios.newsku.errors.NewskuUserException;
import com.github.lamarios.newsku.models.ReadItemHandling;
import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.persistence.repositories.FeedCategoryRepository;
import com.github.lamarios.newsku.persistence.repositories.FeedRepository;
import com.github.lamarios.newsku.persistence.repositories.UserRepository;
import com.github.lamarios.newsku.services.UserService;
import com.github.lamarios.newsku.utils.BackgroundTaskUtils;
import com.github.lamarios.newsku.utils.TestUserService;
import java.nio.file.AccessDeniedException;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Testcontainers;

@SuppressWarnings("SpringBootApplicationProperties")
@SpringBootTest(
    classes = Application.class,
    properties = {"spring.main.allow-bean-definition-overriding=true", "ALLOW_SIGNUP=1"},
    webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@Testcontainers
public abstract class TestContainerTest {
  @Autowired private SignUpController signUpController;
  private static final PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:18");

  static {
    postgres.start();
  }

  @Autowired private UserService userService;
  @Autowired private UserRepository userRepository;
  @Autowired private FeedCategoryRepository feedCategoryRepository;
  @Autowired private FeedRepository feedRepository;

  @DynamicPropertySource
  static void configureSQLContainer(DynamicPropertyRegistry registry) {
    registry.add("spring.datasource.url", postgres::getJdbcUrl);
    registry.add("spring.datasource.username", postgres::getUsername);
    registry.add("spring.datasource.password", postgres::getPassword);
    registry.add("spring.flyway.url", postgres::getJdbcUrl);
    registry.add("spring.flyway.user", postgres::getUsername);
    registry.add("spring.flyway.password", postgres::getPassword);
  }

  @AfterEach
  public void cleaningDB() {
    // since adding feeds will create lots of background tasks
    // we make sure that there is not pending stuff when we proceed with a new test
    BackgroundTaskUtils.waitForTasksToFinish();

    feedRepository.deleteAll();
    feedCategoryRepository.deleteAll();
    userRepository.deleteAll();
  }

  @BeforeEach
  public void insertBaseData() throws AccessDeniedException, NewskuUserException {
    User user = new User();
    user.setPassword("test");
    user.setUsername("test");
    user.setEmail("test@test.com");
    user.setReadItemHandling(ReadItemHandling.none);
    user = signUpController.signup(user);

    ((TestUserService) userService).setCurrentUser(user);
  }
}

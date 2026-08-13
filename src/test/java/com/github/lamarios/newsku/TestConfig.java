package com.github.lamarios.newsku;

import com.github.lamarios.newsku.persistence.repositories.UserRepository;
import com.github.lamarios.newsku.services.EmailService;
import com.github.lamarios.newsku.services.OpenaiService;
import com.github.lamarios.newsku.services.UserService;
import com.github.lamarios.newsku.utils.FakeRssFeedController;
import com.github.lamarios.newsku.utils.MockEmailService;
import com.github.lamarios.newsku.utils.MockOpenaiService;
import com.github.lamarios.newsku.utils.TestUserService;
import freemarker.template.Configuration;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.PropertySource;
import org.springframework.security.crypto.password.PasswordEncoder;

@TestConfiguration
@PropertySource("classpath:application.properties")
public class TestConfig {
  @Bean
  public OpenaiService openaiService() {
    return new MockOpenaiService();
  }

  @Bean
  public EmailService emailService(Configuration templateEngine) {
    return new MockEmailService(templateEngine);
  }

  @Bean
  public UserService userService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
    return new TestUserService(userRepository, passwordEncoder);
  }

  @Bean
  public FakeRssFeedController fakeRssFeedController() {
    return new FakeRssFeedController();
  }
}

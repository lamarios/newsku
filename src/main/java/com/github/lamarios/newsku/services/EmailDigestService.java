package com.github.lamarios.newsku.services;

import com.github.lamarios.newsku.models.EmailDigestFrequency;
import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.persistence.repositories.FeedItemRepository;
import com.github.lamarios.newsku.persistence.repositories.FeedRepository;
import com.github.lamarios.newsku.persistence.repositories.UserRepository;
import freemarker.template.TemplateException;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class EmailDigestService {
  private final UserRepository userRepository;
  private final EmailService emailService;
  private final FeedItemRepository feedItemRepository;
  private static final Logger log = LogManager.getLogger();
  private final FeedRepository feedRepository;

  @Autowired
  public EmailDigestService(
      UserRepository userRepository,
      EmailService emailService,
      FeedItemRepository feedItemRepository,
      FeedRepository feedRepository) {
    this.userRepository = userRepository;
    this.emailService = emailService;
    this.feedItemRepository = feedItemRepository;
    this.feedRepository = feedRepository;
  }

  @Scheduled(cron = "@monthly")
  @Transactional(readOnly = true)
  public void sendMonthlyDigest() {
    log.info("Send monthly digest");
    sendDigestToUsers(EmailDigestFrequency.monthly);
  }

  @Scheduled(cron = "@daily")
  @Transactional(readOnly = true)
  public void sendDailyDigest() {
    log.info("Send daily digest");
    sendDigestToUsers(EmailDigestFrequency.daily);
  }

  @Scheduled(cron = "@weekly")
  @Transactional(readOnly = true)
  public void sendWeeklyDigest() {
    log.info("Send weekly digest");
    sendDigestToUsers(EmailDigestFrequency.weekly);
  }

  @Transactional(readOnly = true)
  public List<User> getUsers(EmailDigestFrequency frequency) {
    return userRepository.findAll().stream()
        .filter(u -> u.getEmailDigest().contains(frequency))
        .toList();
  }

  @Transactional(readOnly = true)
  public void sendDigestToUsers(EmailDigestFrequency frequency) {
    var users = getUsers(frequency);
    for (User user : users) {
      try {
        sendDigest(user, frequency);
      } catch (TemplateException | IOException e) {
        log.error("Could not send digest to users for user " + user.getId(), e);
      }
    }
  }

  @Transactional(readOnly = true)
  public void sendDigest(User user, EmailDigestFrequency frequency)
      throws TemplateException, IOException {
    log.info("Sending {} digest for user {}", frequency.name(), user.getId());
    var feeds = feedRepository.getFeedsByUser(user);
    var to = System.currentTimeMillis();
    var from = to - frequency.getDaysMs();

    var items =
        feedItemRepository.findallByTimeAndFeeds(
            0, from, to, feeds, PageRequest.of(0, 10, Sort.by(Sort.Direction.DESC, "importance")));

    if (items.getContent().isEmpty()) {
      log.info(
          "No feed items found for user {} in the past {} days", user.getId(), frequency.getDays());
      return;
    }

    HashMap<String, Object> data = new HashMap<>();
    data.put("items", items.getContent());
    data.put("username", user.getUsername());
    data.put("frequency", frequency.getEmailTitle().toLowerCase());
    data.put("title", frequency.getEmailTitle());
    emailService.sendTemplate(user.getEmail(), frequency.getEmailTitle(), "email/digest.ftl", data);
  }
}

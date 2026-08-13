package com.github.lamarios.newsku.services;

import static org.junit.jupiter.api.Assertions.*;
import com.github.lamarios.newsku.TestConfig;
import com.github.lamarios.newsku.TestContainerTest;
import com.github.lamarios.newsku.controllers.FeedController;
import com.github.lamarios.newsku.errors.NewskuException;
import com.github.lamarios.newsku.models.EmailDigestFrequency;
import com.github.lamarios.newsku.persistence.entities.FeedItem;
import com.github.lamarios.newsku.persistence.repositories.UserRepository;
import com.github.lamarios.newsku.utils.MockEmailService;
import java.util.Arrays;
import java.util.List;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.context.annotation.Import;

@SuppressWarnings("unchecked")
@Import(TestConfig.class)
public class EmailDigestServiceTest extends TestContainerTest {
    private final UserService userService;
    private final EmailDigestService emailDigestService;
    private final UserRepository userRepository;
    private final EmailService emailService;
    private final FeedController feedController;
    private final FeedItemService feedItemService;
    @LocalServerPort
    private int port;

    @Autowired
    public EmailDigestServiceTest(
            UserService userService,
            EmailDigestService emailDigestService,
            UserRepository userRepository,
            EmailService emailService,
            FeedController feedController,
            FeedItemService feedItemService
    ) {
        this.userService = userService;
        this.emailDigestService = emailDigestService;
        this.userRepository = userRepository;
        this.emailService = emailService;
        this.feedController = feedController;
        this.feedItemService = feedItemService;
    }

    @BeforeEach
    public void setUp() {
        setUserSchedule();
    }

    @Test
    public void testDigest() throws NewskuException {
        String url = "http://localhost:" + port + "/test/rss/one-month-feed";
        var feed = feedController.addFeed(url, true);

        feedItemService.refreshFeedWorker(feed);

        emailDigestService.sendMonthlyDigest();
        // we then check out email queue and see what we have;
        var email = ((MockEmailService) emailService).getEmails().poll();
        assertNotNull(email);

        var items = (List<FeedItem>) email.data().get("items");
        assertEquals(10, items.size());

        var fromTime = System.currentTimeMillis() - (EmailDigestFrequency.monthly.getDaysMs());
        assertTrue(items
            .stream()
            .allMatch(feedItem -> feedItem.getTimeCreated() > fromTime));
        // if we request for weekly items, we should only have 7 items max
        emailDigestService.sendWeeklyDigest();

        email = ((MockEmailService) emailService).getEmails().poll();
        assertNotNull(email);

        items = (List<FeedItem>) email.data().get("items");
        assertEquals(7, items.size());

        var fromTimeWeekly = System.currentTimeMillis() - (EmailDigestFrequency.weekly.getDaysMs());
        assertTrue(items
            .stream()
            .allMatch(feedItem -> feedItem.getTimeCreated() > fromTimeWeekly));

        emailDigestService.sendDailyDigest();

        email = ((MockEmailService) emailService).getEmails().poll();
        assertNotNull(email);

        items = (List<FeedItem>) email.data().get("items");
        assertEquals(1, items.size());

        var fromTimeDaily = System.currentTimeMillis() - (EmailDigestFrequency.daily.getDaysMs());
        assertTrue(items
            .stream()
            .allMatch(feedItem -> feedItem.getTimeCreated() > fromTimeDaily));
    }

    private void setUserSchedule() {
        // we set our user to have the monthly digest
        var user = userService.getCurrentUser();
        assertNull(user.getEmailDigest());

        user.setEmailDigest(Arrays.stream(EmailDigestFrequency.values()).toList());
        userService.updateUser(user);

        user = userRepository.findFirstById(user.getId());

        assertEquals(3, user.getEmailDigest().size());
    }
}

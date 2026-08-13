package com.github.lamarios.newsku.controllers;

import static org.junit.jupiter.api.Assertions.assertTrue;
import com.github.lamarios.newsku.TestConfig;
import com.github.lamarios.newsku.TestContainerTest;
import com.github.lamarios.newsku.errors.NewskuException;
import com.github.lamarios.newsku.persistence.entities.FeedItem;
import com.github.lamarios.newsku.services.FeedItemService;
import java.sql.SQLException;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.context.annotation.Import;

@Import(TestConfig.class)
public class FeedItemControllerTest extends TestContainerTest {
    @Autowired
    private FeedItemController feedItemController;
    @Autowired
    private FeedItemService feedItemService;
    @Autowired
    private FeedController feedController;
    @LocalServerPort
    private int port;

    @Test
    public void testFeedItems() throws SQLException, NewskuException {
        String url = "http://localhost:" + port + "/test/rss/one-month-feed";
        var feed = feedController.addFeed(url, true);

        feedItemService.refreshFeedWorker(feed);

        var items = feedItemController.getItems(0L, System.currentTimeMillis(), 0, 9999999);

        assertTrue(items.hasContent());

        assertTrue(items.getContent().stream().noneMatch(FeedItem::isRead));

        feedItemController.readArticles(items.getContent().stream().map(FeedItem::getId).toList());

        items = feedItemController.getItems(0L, System.currentTimeMillis(), 0, 9999999);
        assertTrue(items.getContent().stream().allMatch(FeedItem::isRead));
    }
}

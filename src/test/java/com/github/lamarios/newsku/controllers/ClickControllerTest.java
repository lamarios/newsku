package com.github.lamarios.newsku.controllers;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.github.lamarios.newsku.TestConfig;
import com.github.lamarios.newsku.TestContainerTest;
import com.github.lamarios.newsku.errors.NewskuException;
import com.github.lamarios.newsku.models.TagClickStat;
import com.github.lamarios.newsku.services.FeedItemService;
import java.sql.SQLException;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Import;

@Import(TestConfig.class)
public class ClickControllerTest extends TestContainerTest {
  @Autowired private FeedItemController feedItemController;
  @Autowired private FeedItemService feedItemService;
  @Autowired private FeedController feedController;
  @Autowired private ClickController clickController;

  @Test
  public void testClickFeedItem() throws SQLException, NewskuException {
    var feed = feedController.addFeed("https://feeds.arstechnica.com/arstechnica/index");

    feedItemService.refreshFeedWorker(feed);

    var items = feedItemController.getItems(0L, System.currentTimeMillis(), 0, 9999999);

    assertTrue(items.hasContent());

    feedItemController.clickItem(items.getContent().getFirst().getId());

    var stats = clickController.getTagStats(0L, System.currentTimeMillis());

    assertEquals(2, stats.tagClicks().size());

    var clickedTags = stats.tagClicks().stream().map(TagClickStat::tag).toList();

    assertTrue(clickedTags.contains(items.getContent().getFirst().getTags().get(0)));
    assertTrue(clickedTags.contains(items.getContent().getFirst().getTags().get(1)));

    assertTrue(stats.tagClicks().stream().map(TagClickStat::clicks).allMatch(aLong -> aLong == 1));

    assertEquals(1, stats.feedClicks().size());
    var feedClick = stats.feedClicks().getFirst();
    assertEquals(feed.getUrl(), feedClick.feed().getUrl());
    assertEquals(1, feedClick.clicks());
  }
}

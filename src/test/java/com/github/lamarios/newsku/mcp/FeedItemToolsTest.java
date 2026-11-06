package com.github.lamarios.newsku.mcp;

import static org.junit.jupiter.api.Assertions.*;

import com.github.lamarios.newsku.TestConfig;
import com.github.lamarios.newsku.TestContainerTest;
import com.github.lamarios.newsku.controllers.FeedController;
import com.github.lamarios.newsku.models.ReadItemHandling;
import com.github.lamarios.newsku.persistence.entities.Feed;
import com.github.lamarios.newsku.persistence.entities.FeedItem;
import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.persistence.repositories.ApiKeyRepository;
import com.github.lamarios.newsku.persistence.repositories.FeedItemRepository;
import com.github.lamarios.newsku.persistence.repositories.UserRepository;
import com.github.lamarios.newsku.services.ApiKeyService;
import com.github.lamarios.newsku.services.FeedItemService;
import com.github.lamarios.newsku.services.UserService;
import com.github.lamarios.newsku.utils.TestUserService;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneOffset;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import kong.unirest.core.HttpResponse;
import kong.unirest.core.JsonNode;
import kong.unirest.core.Unirest;
import kong.unirest.core.json.JSONObject;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.context.annotation.Import;

@Import(TestConfig.class)
public class FeedItemToolsTest extends TestContainerTest {
  @Autowired private FeedController feedController;
  @Autowired private FeedItemService feedItemService;
  @Autowired private ApiKeyService apiKeyService;
  @Autowired private ApiKeyRepository apiKeyRepository;
  @Autowired private UserService userService;
  @Autowired private UserRepository userRepository;
  @Autowired private FeedItemRepository feedItemRepository;
  @LocalServerPort private int port;

  @AfterEach
  public void tearDown() {
    apiKeyRepository.deleteAll();
  }

  @Test
  public void testParseDate() {
    long dayStart =
        LocalDate.of(2025, 11, 1).atStartOfDay(ZoneOffset.UTC).toInstant().toEpochMilli();
    long nextDayStart =
        LocalDate.of(2025, 11, 2).atStartOfDay(ZoneOffset.UTC).toInstant().toEpochMilli();

    assertEquals(dayStart, FeedItemTools.parseDate("2025-11-01", "from", false));
    assertEquals(nextDayStart - 1, FeedItemTools.parseDate("2025-11-01", "to", true));
    assertEquals(dayStart, FeedItemTools.parseDate("2025-11-01T00:00:00Z", "from", false));
    assertEquals(dayStart, FeedItemTools.parseDate("2025-11-01T00:00:00", "from", false));
    assertEquals(dayStart, FeedItemTools.parseDate("2025-11-01T02:00:00+02:00", "from", false));

    assertThrows(
        IllegalArgumentException.class, () -> FeedItemTools.parseDate("yesterday", "from", false));
    assertThrows(IllegalArgumentException.class, () -> FeedItemTools.parseDate(" ", "from", false));
  }

  @Test
  public void testGetFeedItemsOverMcp() throws Exception {
    var feed =
        feedController.addFeed("http://localhost:" + port + "/test/rss/one-month-feed", true);
    feedItemService.refreshFeedWorker(feed);

    String key = apiKeyService.createApiKey("mcp", null).key();
    var user = userService.getCurrentUser();
    long lastRefreshBefore = userRepository.findById(user.getId()).orElseThrow().getLastRefresh();

    Instant to = Instant.now();
    Instant from = to.minus(7, ChronoUnit.DAYS);
    long expected =
        feedItemService.findItems(from.toEpochMilli(), to.toEpochMilli(), 0, 1).getTotalElements();
    assertTrue(expected > 2);

    // from now on the user has to come from the API key authentication
    ((TestUserService) userService).setCurrentUser(null);

    // tools are listed
    var tools = mcp(key, "tools/list", Map.of());
    assertEquals(200, tools.getStatus());
    var toolList = tools.getBody().getObject().getJSONObject("result").getJSONArray("tools");
    var toolNames =
        IntStream.range(0, toolList.length())
            .mapToObj(i -> toolList.getJSONObject(i).getString("name"))
            .collect(Collectors.toSet());
    assertEquals(Set.of("get_feed_items", "mark_feed_items_as_read"), toolNames);

    var call =
        mcp(
            key,
            "tools/call",
            Map.of(
                "name",
                "get_feed_items",
                "arguments",
                Map.of("from", from.toString(), "to", to.toString(), "pageSize", 2)));
    assertEquals(200, call.getStatus());

    var result = call.getBody().getObject().getJSONObject("result");
    assertFalse(result.optBoolean("isError", false), result.toString());

    JSONObject page = structuredOrText(result);
    assertEquals(expected, page.getLong("totalItems"));
    assertEquals(2, page.getJSONArray("items").length());
    assertTrue(
        page.getJSONArray("items").getJSONObject(0).getString("title").startsWith("Newsku unit"));

    // reading items through MCP must not mark them as seen
    assertEquals(
        lastRefreshBefore, userRepository.findById(user.getId()).orElseThrow().getLastRefresh());

    // invalid dates are reported as tool errors
    var invalid =
        mcp(
            key,
            "tools/call",
            Map.of(
                "name",
                "get_feed_items",
                "arguments",
                Map.of("from", "last week", "to", to.toString())));
    assertTrue(invalid.getBody().getObject().getJSONObject("result").getBoolean("isError"));

    // no or wrong key gets rejected
    assertEquals(401, mcp(null, "tools/list", Map.of()).getStatus());
    assertEquals(401, mcp("nsk_wrong", "tools/list", Map.of()).getStatus());
  }

  @Test
  public void testItemAtMidnightIsIncluded() throws Exception {
    var feed =
        feedController.addFeed("http://localhost:" + port + "/test/rss/one-month-feed", true);

    FeedItem item = new FeedItem();
    item.setId(UUID.randomUUID().toString());
    item.setGuid(item.getId());
    item.setFeed(feed);
    item.setTitle("Published at midnight");
    item.setImportance(100);
    item.setTags(List.of());
    item.setTimeCreated(
        LocalDate.of(2025, 1, 2).atStartOfDay(ZoneOffset.UTC).toInstant().toEpochMilli());
    feedItemRepository.save(item);

    String key = apiKeyService.createApiKey("mcp", null).key();
    ((TestUserService) userService).setCurrentUser(null);

    // 'from' is inclusive, the item is on the 2nd only
    assertEquals(1, countItems(key, "2025-01-02", "2025-01-02"));
    assertEquals(0, countItems(key, "2025-01-01", "2025-01-01"));
  }

  @Test
  public void testMarkItemsAsRead() throws Exception {
    var user = userService.getCurrentUser();
    var feed =
        feedController.addFeed("http://localhost:" + port + "/test/rss/one-month-feed", true);
    var first = saveItem(feed, "first");
    var second = saveItem(feed, "second");
    var untouched = saveItem(feed, "untouched");

    // an item from someone else's feed must not be markable
    User other = new User();
    other.setUsername("other");
    other.setPassword("other");
    other.setEmail("other@test.com");
    other.setReadItemHandling(ReadItemHandling.none);
    other = userService.createUser(other);
    ((TestUserService) userService).setCurrentUser(other);
    var otherFeed =
        feedController.addFeed("http://localhost:" + port + "/test/rss/one-month-feed", true);
    var othersItem = saveItem(otherFeed, "not mine");

    ((TestUserService) userService).setCurrentUser(user);
    String key = apiKeyService.createApiKey("mcp", null).key();
    ((TestUserService) userService).setCurrentUser(null);

    var response =
        mcp(
            key,
            "tools/call",
            Map.of(
                "name",
                "mark_feed_items_as_read",
                "arguments",
                Map.of(
                    "ids",
                    List.of(
                        first.getId(),
                        second.getId(),
                        first.getId(),
                        othersItem.getId(),
                        "nope"))));
    var result = response.getBody().getObject().getJSONObject("result");
    assertFalse(result.optBoolean("isError", false), result.toString());

    var body = structuredOrText(result);
    var marked = body.getJSONArray("markedAsRead").toList();
    var notFound = body.getJSONArray("notFound").toList();
    assertEquals(2, marked.size());
    assertTrue(marked.containsAll(List.of(first.getId(), second.getId())));
    assertEquals(List.of(othersItem.getId(), "nope"), notFound);

    assertTrue(feedItemRepository.findById(first.getId()).orElseThrow().isRead());
    assertTrue(feedItemRepository.findById(second.getId()).orElseThrow().isRead());
    assertFalse(feedItemRepository.findById(untouched.getId()).orElseThrow().isRead());
    assertFalse(feedItemRepository.findById(othersItem.getId()).orElseThrow().isRead());

    // empty list is an error
    var empty =
        mcp(
            key,
            "tools/call",
            Map.of("name", "mark_feed_items_as_read", "arguments", Map.of("ids", List.of())));
    assertTrue(empty.getBody().getObject().getJSONObject("result").getBoolean("isError"));
  }

  private FeedItem saveItem(Feed feed, String title) {
    FeedItem item = new FeedItem();
    item.setId(UUID.randomUUID().toString());
    item.setGuid(item.getId());
    item.setFeed(feed);
    item.setTitle(title);
    item.setImportance(50);
    item.setTags(List.of());
    item.setTimeCreated(System.currentTimeMillis());
    return feedItemRepository.save(item);
  }

  @Test
  public void testExpiredKeyCantUseMcp() throws Exception {
    var created = apiKeyService.createApiKey("mcp", System.currentTimeMillis() + 60_000);
    var stored = apiKeyRepository.findById(created.apiKey().getId()).orElseThrow();
    stored.setExpiresAt(System.currentTimeMillis() - 1);
    apiKeyRepository.save(stored);

    ((TestUserService) userService).setCurrentUser(null);
    assertEquals(401, mcp(created.key(), "tools/list", Map.of()).getStatus());
  }

  private long countItems(String key, String from, String to) {
    var result =
        mcp(
                key,
                "tools/call",
                Map.of("name", "get_feed_items", "arguments", Map.of("from", from, "to", to)))
            .getBody()
            .getObject()
            .getJSONObject("result");
    assertFalse(result.optBoolean("isError", false), result.toString());
    return structuredOrText(result).getLong("totalItems");
  }

  private HttpResponse<JsonNode> mcp(String key, String method, Map<String, Object> params) {
    var request =
        Unirest.post("http://localhost:" + port + "/api/mcp")
            .header("Content-Type", "application/json")
            .header("Accept", "application/json, text/event-stream");
    if (key != null) {
      request = request.header("Authorization", key);
    }
    return request
        .body(Map.of("jsonrpc", "2.0", "id", 1, "method", method, "params", params))
        .asJson();
  }

  private JSONObject structuredOrText(JSONObject result) {
    if (result.has("structuredContent")) {
      return result.getJSONObject("structuredContent");
    }
    return new JSONObject(result.getJSONArray("content").getJSONObject(0).getString("text"));
  }
}

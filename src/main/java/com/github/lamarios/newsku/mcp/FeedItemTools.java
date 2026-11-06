package com.github.lamarios.newsku.mcp;

import com.github.lamarios.newsku.models.McpFeedItem;
import com.github.lamarios.newsku.services.FeedItemService;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeParseException;
import java.util.List;
import org.springframework.ai.mcp.annotation.McpTool;
import org.springframework.ai.mcp.annotation.McpToolParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class FeedItemTools {
  public static final int DEFAULT_PAGE_SIZE = 50;
  public static final int MAX_PAGE_SIZE = 100;
  public static final int MAX_ITEMS_TO_MARK = 500;

  private final FeedItemService feedItemService;

  @Autowired
  public FeedItemTools(FeedItemService feedItemService) {
    this.feedItemService = feedItemService;
  }

  public record FeedItemsPage(
      List<McpFeedItem> items, int page, int pageSize, int totalPages, long totalItems) {}

  public record MarkAsReadResult(List<String> markedAsRead, List<String> notFound) {}

  @McpTool(
      name = "get_feed_items",
      title = "Get feed items",
      description =
          "Returns the articles from the user's RSS feeds published within a date range, most"
              + " important first. Importance is a 0-100 score given by an AI based on the user's"
              + " preferences, articles below the user's minimum importance are excluded. Results"
              + " are paginated, keep requesting the next page while page + 1 < totalPages if you"
              + " need more.",
      annotations =
          @McpTool.McpAnnotations(
              title = "Get feed items",
              readOnlyHint = true,
              destructiveHint = false,
              idempotentHint = true,
              openWorldHint = false))
  public FeedItemsPage getFeedItems(
      @McpToolParam(
              description =
                  "Start of the range (inclusive), ISO-8601. Either a date (2025-11-01, start of"
                      + " day UTC) or a date-time (2025-11-01T08:00:00Z or with an offset)")
          String from,
      @McpToolParam(
              description =
                  "End of the range (inclusive), ISO-8601. Either a date (2025-11-01, end of day"
                      + " UTC) or a date-time (2025-11-01T18:00:00Z or with an offset)")
          String to,
      @McpToolParam(description = "Page number, starting at 0. Defaults to 0", required = false)
          Integer page,
      @McpToolParam(
              description = "Number of items per page, between 1 and 100. Defaults to 50",
              required = false)
          Integer pageSize) {
    long fromMillis = parseDate(from, "from", false);
    long toMillis = parseDate(to, "to", true);
    if (fromMillis > toMillis) {
      throw new IllegalArgumentException("'from' must be before 'to'");
    }

    int p = page == null ? 0 : Math.max(0, page);
    int size = pageSize == null ? DEFAULT_PAGE_SIZE : Math.clamp(pageSize, 1, MAX_PAGE_SIZE);

    // the query's lower bound is exclusive, -1 so items exactly at 'from' (e.g. midnight) are
    // included
    var result = feedItemService.findItems(fromMillis - 1, toMillis, p, size);

    return new FeedItemsPage(
        result.getContent().stream().map(McpFeedItem::from).toList(),
        p,
        size,
        result.getTotalPages(),
        result.getTotalElements());
  }

  @McpTool(
      name = "mark_feed_items_as_read",
      title = "Mark feed items as read",
      description =
          "Marks articles as read, using the ids returned by get_feed_items. Marking an article that"
              + " is already read has no effect. Returns the ids that were marked as read and the"
              + " ones that couldn't be found.",
      annotations =
          @McpTool.McpAnnotations(
              title = "Mark feed items as read",
              readOnlyHint = false,
              destructiveHint = false,
              idempotentHint = true,
              openWorldHint = false))
  public MarkAsReadResult markFeedItemsAsRead(
      @McpToolParam(description = "Ids of the articles to mark as read, at most 500")
          List<String> ids) {
    if (ids == null || ids.isEmpty()) {
      throw new IllegalArgumentException("'ids' must contain at least one article id");
    }
    if (ids.size() > MAX_ITEMS_TO_MARK) {
      throw new IllegalArgumentException(
          "Too many ids, at most " + MAX_ITEMS_TO_MARK + " can be marked at once");
    }

    var distinctIds = ids.stream().distinct().toList();
    var marked = feedItemService.markItemsAsRead(distinctIds);
    var notFound = distinctIds.stream().filter(id -> !marked.contains(id)).toList();

    return new MarkAsReadResult(marked, notFound);
  }

  /**
   * Parses an ISO-8601 date or date-time to epoch millis. Date-times without an offset and plain
   * dates are considered UTC. A plain date is the start of the day, or its last millisecond when
   * endOfDay is true.
   */
  static long parseDate(String value, String paramName, boolean endOfDay) {
    if (value == null || value.isBlank()) {
      throw new IllegalArgumentException("'" + paramName + "' is required");
    }
    value = value.trim();

    try {
      return OffsetDateTime.parse(value).toInstant().toEpochMilli();
    } catch (DateTimeParseException ignored) {
    }

    try {
      return LocalDateTime.parse(value).toInstant(ZoneOffset.UTC).toEpochMilli();
    } catch (DateTimeParseException ignored) {
    }

    try {
      LocalDate date = LocalDate.parse(value);
      Instant instant =
          endOfDay
              ? date.plusDays(1).atStartOfDay(ZoneOffset.UTC).toInstant().minusMillis(1)
              : date.atStartOfDay(ZoneOffset.UTC).toInstant();
      return instant.toEpochMilli();
    } catch (DateTimeParseException e) {
      throw new IllegalArgumentException(
          "'" + paramName + "' is not a valid ISO-8601 date or date-time: " + value);
    }
  }
}

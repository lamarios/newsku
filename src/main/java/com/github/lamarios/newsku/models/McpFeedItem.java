package com.github.lamarios.newsku.models;

import com.github.lamarios.newsku.persistence.entities.FeedItem;
import com.github.lamarios.newsku.utils.HtmlUtils;
import java.time.Instant;
import java.util.List;

/** Compact version of a {@link FeedItem} for MCP clients, without the full article content. */
public record McpFeedItem(
    String id,
    String title,
    String summary,
    String url,
    String feed,
    String category,
    String publishedAt,
    int importance,
    String importanceReasoning,
    List<String> tags,
    boolean read) {

  public static McpFeedItem from(FeedItem item) {
    var feed = item.getFeed();
    return new McpFeedItem(
        item.getId(),
        item.getTitle(),
        item.getDescription() == null ? null : HtmlUtils.getTextContent(item.getDescription()),
        item.getUrl(),
        feed == null ? null : feed.getName(),
        feed == null || feed.getCategory() == null ? null : feed.getCategory().getName(),
        Instant.ofEpochMilli(item.getTimeCreated()).toString(),
        item.getImportance(),
        item.getReasoning(),
        item.getTags(),
        item.isRead());
  }
}

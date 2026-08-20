package com.github.lamarios.newsku.controllers;

import static com.github.lamarios.newsku.controllers.ImageController.serveFile;

import be.ceau.opml.OpmlWriteException;
import com.github.lamarios.newsku.errors.NewskuException;
import com.github.lamarios.newsku.models.FeedToImport;
import com.github.lamarios.newsku.persistence.entities.Feed;
import com.github.lamarios.newsku.persistence.entities.FeedItem;
import com.github.lamarios.newsku.services.FeedItemService;
import com.github.lamarios.newsku.services.FeedService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import org.apache.commons.io.IOUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.bind.DefaultValue;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody;

@RestController
@RequestMapping("/api/feeds")
@Tag(name = "Feeds")
@SecurityRequirement(name = "bearerAuth")
public class FeedController {
  private final FeedService feedService;
  private final FeedItemService feedItemService;
  private final Logger log = LogManager.getLogger();
  private final boolean demoMode;

  @Autowired
  public FeedController(
      FeedService feedService,
      FeedItemService feedItemService,
      @Value("${DEMO_MODE:0}") boolean demoMode) {
    this.feedService = feedService;
    this.feedItemService = feedItemService;
    this.demoMode = demoMode;
  }

  @GetMapping
  public List<Feed> getFeeds() {
    return feedService.getFeeds();
  }

  @PostMapping
  public Feed updateFeed(@RequestBody Feed feed) throws AccessDeniedException {
    if (demoMode) {
      throw new AccessDeniedException("App in demoMode");
    }
    return feedService.updateFeed(feed);
  }

  @PutMapping
  public Feed addFeed(@RequestBody String url) throws NewskuException {
    return addFeed(url, false);
  }

  /**
   * Adds a new RSS feed for the logged in user
   *
   * @param url the url of the feed
   * @param skipRefresh skip refreshing the feed, mostly used for unit test
   * @return the newly added feed
   * @throws NewskuException if anything goes wrong while adding the feed
   */
  public Feed addFeed(String url, boolean skipRefresh) throws NewskuException {
    if (demoMode) {
      throw new AccessDeniedException("App in demoMode");
    }
    var feed = feedService.addFeed(url);
    if (!skipRefresh) {
      feedItemService.refreshFeed(feed);
    }
    return feed;
  }

  @DeleteMapping("{id}")
  public boolean deleteFeed(@PathVariable String id) throws AccessDeniedException {
    if (demoMode) {
      throw new AccessDeniedException("App in demoMode");
    }
    return feedService.deleteFeed(id);
  }

  @PostMapping(value = "/import", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
  public List<FeedToImport> importFeed(@RequestParam("file") MultipartFile file)
      throws NewskuException {
    if (demoMode) {
      throw new AccessDeniedException("App in demoMode");
    }
    var newFeeds = feedService.getFeedsFromOpml(file);
    log.info("Found {} new feeds, importing them in the background", newFeeds.size());

    newFeeds.forEach(feedService::importFeed);
    return newFeeds;
  }

  @GetMapping("/export")
  public ResponseEntity<@NotNull StreamingResponseBody> exportFeeds() throws NewskuException {
    try {
      if (demoMode) {
        throw new AccessDeniedException("App in demoMode");
      }
      Path p = Files.createTempFile("ompl-export", ".opml");
      String opml = feedService.exportFeed();

      try (PrintWriter printer = new PrintWriter(p.toFile().getAbsolutePath())) {
        IOUtils.write(opml, printer);
      }
      return serveFile(p);
    } catch (IOException | OpmlWriteException e) {
      log.error(e);
      throw new NewskuException("Failed to export feeds");
    }
  }

  @GetMapping("{id}/items")
  public Page<FeedItem> getFeedItems(
      @PathVariable String id,
      @Min(0) @DefaultValue("0") @RequestParam Integer page,
      @Min(0) @Max(500) @DefaultValue("100") @RequestParam Integer pageSize) {
    return feedItemService.getFeedItems(id, page, pageSize);
  }
}

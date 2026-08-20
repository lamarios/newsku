package com.github.lamarios.newsku.controllers;

import com.github.lamarios.newsku.persistence.entities.FeedItem;
import com.github.lamarios.newsku.services.FeedItemService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.security.InvalidParameterException;
import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.bind.DefaultValue;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/feeds/items")
@Tag(name = "Feeds")
@SecurityRequirement(name = "bearerAuth")
public class FeedItemController {
  private final FeedItemService feedItemService;
  private final Logger log = LogManager.getLogger();

  @Autowired
  public FeedItemController(FeedItemService feedItemService) {
    this.feedItemService = feedItemService;
  }

  @GetMapping
  public Page<FeedItem> getItems(
      @RequestParam("from") Long from,
      @RequestParam("to") Long to,
      @DefaultValue("0") @RequestParam("page") int page,
      @DefaultValue("100") @RequestParam("pageSize") int pageSize) {
    if (from == null || to == null) {
      throw new InvalidParameterException("from and to query parameters are required");
    }
    return feedItemService.getItems(from, to, page, pageSize);
  }

  @PostMapping("/read")
  public boolean readArticles(@RequestBody List<String> ids) {
    log.info("Changing read status of {} items", ids.size());
    return feedItemService.readItems(ids);
  }

  @PutMapping("/{id}/click")
  public void clickItem(@PathVariable String id) {
    feedItemService.itemClicked(id);
  }
}

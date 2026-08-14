package com.github.lamarios.newsku.controllers;

import com.github.lamarios.newsku.models.ClickStats;
import com.github.lamarios.newsku.services.ClickService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.security.InvalidParameterException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/clicks")
@Tag(name = "Clicks")
@SecurityRequirement(name = "bearerAuth")
public class ClickController {
  private final ClickService clickService;

  @Autowired
  public ClickController(ClickService clickService) {
    this.clickService = clickService;
  }

  @GetMapping
  public ClickStats getTagStats(@RequestParam("from") Long from, @RequestParam("to") Long to) {
    if (from == null || to == null) {
      throw new InvalidParameterException("from and to query parameters are required");
    }

    var tagClick = clickService.tagClicks(from, to);
    var feedClicks = clickService.feedClicks(from, to);

    tagClick.sort((o1, o2) -> Long.compare(o2.clicks(), o1.clicks()));
    feedClicks.sort((o1, o2) -> Long.compare(o2.clicks(), o1.clicks()));

    return new ClickStats(tagClick, feedClicks);
  }
}

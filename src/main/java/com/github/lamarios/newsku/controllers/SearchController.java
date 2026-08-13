package com.github.lamarios.newsku.controllers;

import com.github.lamarios.newsku.persistence.entities.FeedItem;
import com.github.lamarios.newsku.services.FeedItemService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/search")
@Tag(name = "Search")
@SecurityRequirement(name = "bearerAuth")
public class SearchController {
    private final FeedItemService feedItemService;

    public SearchController(FeedItemService feedItemService) {
        this.feedItemService = feedItemService;
    }

    @GetMapping
    public List<FeedItem> seeach(
            @RequestParam("query") String query,
            @RequestParam("page") int page,
            @RequestParam("pageSize") int size
    ) {
        return feedItemService.search(query, page, size);
    }
}

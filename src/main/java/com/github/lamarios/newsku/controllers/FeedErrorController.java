package com.github.lamarios.newsku.controllers;

import com.github.lamarios.newsku.persistence.entities.FeedError;
import com.github.lamarios.newsku.services.FeedErrorService;
import com.github.lamarios.newsku.services.FeedService;
import com.github.lamarios.newsku.services.UserService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/feed-errors")
@Tag(name = "FeedsErrors")
@SecurityRequirement(name = "bearerAuth")
public class FeedErrorController {
    private final FeedService feedService;
    private final FeedErrorService feedErrorService;
    private final UserService userService;

    @Autowired
    public FeedErrorController(FeedService feedService, FeedErrorService feedErrorService, UserService userService) {
        this.feedService = feedService;
        this.feedErrorService = feedErrorService;
        this.userService = userService;
    }

    @GetMapping("/last-refresh-count")
    public long countLastRefreshErrors() {
        return feedErrorService.countLastRefreshErrors();
    }

    @GetMapping("{id}")
    public Page<FeedError> getErrors(
            @PathVariable("id") String feedId,
            @RequestParam("page") int page,
            @RequestParam("pageSize") int pageSize
    ) {
        var feed = feedService.getFeed(feedId);
        if (feed == null) {
            return Page.empty();
        }
        return feedErrorService.getPaginatedErrors(feed, page, pageSize);
    }
}

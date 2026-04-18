package com.github.lamarios.newsku.controllers;

import com.github.lamarios.newsku.errors.NewskuException;
import com.github.lamarios.newsku.persistence.entities.FeedCategory;
import com.github.lamarios.newsku.persistence.repositories.FeedCategoryRepository;
import com.github.lamarios.newsku.services.FeedCategoriesService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/feed-categories")
@Tag(name = "Feed Categories")
@SecurityRequirement(name = "bearerAuth")
public class FeedCategoryController {
    private final FeedCategoriesService feedCategoriesService;
    private final Logger log = LogManager.getLogger();
    private final boolean demoMode;

    @Autowired
    public FeedCategoryController(FeedCategoriesService feedCategoriesService, @Value("${DEMO_MODE:0}") boolean demoMode) {
        this.feedCategoriesService = feedCategoriesService;
        this.demoMode = demoMode;
    }

    @GetMapping
    public List<FeedCategory> getCategories() {
        return feedCategoriesService.getCategories();
    }

    @PutMapping
    public FeedCategory addCategory(@RequestBody String name) throws NewskuException {
        if (demoMode) {
            throw new AccessDeniedException("App in demoMode");
        }
        return feedCategoriesService.addCategory(name);
    }

    @PostMapping
    public FeedCategory updateCategory(@RequestBody FeedCategory cat) {
        if (demoMode) {
            throw new AccessDeniedException("App in demoMode");
        }
        return feedCategoriesService.updateCategory(cat);
    }

    @DeleteMapping("{id}")
    public boolean deleteCategory(@PathVariable String id) {
        if (demoMode) {
            throw new AccessDeniedException("App in demoMode");
        }
        return feedCategoriesService.deleteCategory(id);
    }
}

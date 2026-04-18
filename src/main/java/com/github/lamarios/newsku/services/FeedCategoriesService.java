package com.github.lamarios.newsku.services;

import com.github.lamarios.newsku.errors.NewskuException;
import com.github.lamarios.newsku.persistence.entities.FeedCategory;
import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.persistence.repositories.FeedCategoryRepository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.AccessDeniedException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class FeedCategoriesService {
    private final UserService userService;
    private final FeedCategoryRepository feedCategoryRepository;
    private final Logger log = LogManager.getLogger();

    @Autowired
    public FeedCategoriesService(UserService userService, FeedCategoryRepository feedCategoryRepository) {
        this.userService = userService;
        this.feedCategoryRepository = feedCategoryRepository;
    }


    @Transactional
    public FeedCategory addCategory(String name) throws NewskuException {

        if (name == null || name.isBlank()) {
            throw new NewskuException("Category name is empty");
        }

        User user = userService.getCurrentUser();

        FeedCategory category = new FeedCategory();
        category.setId(UUID.randomUUID().toString());
        category.setUser(user);
        category.setName(name);

        feedCategoryRepository.save(category);

        return category;
    }

    @Transactional
    public FeedCategory updateCategory(FeedCategory category) {
        User user = userService.getCurrentUser();
        var oldCat = feedCategoryRepository.getFeedCategoriesByIdAndUser(category.getId(), user);

        if (oldCat == null) {
            throw new AccessDeniedException("You do not own this category");
        } else {
            category.setUser(oldCat.getUser());
            feedCategoryRepository.save(category);
            return category;
        }

    }

    @Transactional
    public boolean deleteCategory(String id) {
        User user = userService.getCurrentUser();

        FeedCategory cat = feedCategoryRepository.getFeedCategoriesByIdAndUser(id, user);

        if (cat != null) {
            feedCategoryRepository.deleteById(id);
            return true;
        } else {
            return false;
        }
    }

    @Transactional(readOnly = true)
    public List<FeedCategory> getCategories() {
        User user = userService.getCurrentUser();

        return feedCategoryRepository.getAllByUser(user, Sort.by("name"));

    }

}

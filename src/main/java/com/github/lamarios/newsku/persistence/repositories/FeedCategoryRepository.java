package com.github.lamarios.newsku.persistence.repositories;

import com.github.lamarios.newsku.persistence.entities.FeedCategory;
import com.github.lamarios.newsku.persistence.entities.User;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FeedCategoryRepository extends JpaRepository<FeedCategory, String> {
    FeedCategory getFeedCategoriesByIdAndUser(String id, User user);

    List<FeedCategory> getAllByUser(User user, Sort sort);
}

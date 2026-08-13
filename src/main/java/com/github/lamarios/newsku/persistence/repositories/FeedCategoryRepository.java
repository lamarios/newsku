package com.github.lamarios.newsku.persistence.repositories;

import com.github.lamarios.newsku.persistence.entities.FeedCategory;
import com.github.lamarios.newsku.persistence.entities.User;
import java.util.List;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FeedCategoryRepository extends JpaRepository<FeedCategory, String> {
    FeedCategory getFeedCategoriesByIdAndUser(String id, User user);

    List<FeedCategory> getAllByUser(User user, Sort sort);

    List<FeedCategory> getAllByUser(User user);
}

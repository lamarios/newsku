package com.github.lamarios.newsku.persistence.repositories;


import com.github.lamarios.newsku.persistence.entities.Feed;
import com.github.lamarios.newsku.persistence.entities.FeedCategory;
import com.github.lamarios.newsku.persistence.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;
import java.util.stream.Stream;

public interface FeedRepository extends JpaRepository<Feed, String> {
    List<Feed> getFeedsByUser(User user);

    User user(User user);

    Feed getFirstById(String id);

    Feed findFirstByIdAndUser(String id, User user);


    List<Feed> findFirstByUrlAndUser(String url, User user);

    @Query("select sum(f.lastRefreshErrors) from Feed f where f.user = :user")
    Long sumFeedsError(@Param("user") User user);

    Stream<Feed> getFeedByUserAndCategory(User user, FeedCategory category);

    @Query("select f from Feed f where f.category is null and f.user = :user")
    Stream<Feed> getFeedByUserAndNullCategory(@Param("user") User user);
}

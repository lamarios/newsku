package com.github.lamarios.newsku.persistence.repositories;

import com.github.lamarios.newsku.persistence.entities.Feed;
import com.github.lamarios.newsku.persistence.entities.FeedClick;
import java.util.Collection;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FeedClicksRepository extends JpaRepository<FeedClick, String> {
    List<FeedClick> getAllByFeedInAndTimeCreatedBetween(
            Collection<Feed> feeds,
            long timeCreatedAfter,
            long timeCreatedBefore
    );
}

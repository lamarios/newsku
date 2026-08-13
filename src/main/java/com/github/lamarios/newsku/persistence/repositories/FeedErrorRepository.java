package com.github.lamarios.newsku.persistence.repositories;

import com.github.lamarios.newsku.persistence.entities.Feed;
import com.github.lamarios.newsku.persistence.entities.FeedError;
import java.util.Collection;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FeedErrorRepository extends JpaRepository<FeedError, String> {
    List<FeedError> findByFeed(Feed feed);

    List<FeedError> findByFeedAndTimeCreatedBetween(Feed feed, long timeCreatedAfter, long timeCreatedBefore);

    int countByFeedAndTimeCreatedBetween(Feed feed, long timeCreatedAfter, long timeCreatedBefore);

    Page findByFeed(Feed feed, Pageable pageable);

    long countByFeedInAndTimeCreatedBetween(Collection<Feed> feeds, long timeCreatedAfter, long timeCreatedBefore);
}

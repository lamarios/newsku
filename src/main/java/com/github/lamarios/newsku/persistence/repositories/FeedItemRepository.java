package com.github.lamarios.newsku.persistence.repositories;

import com.github.lamarios.newsku.persistence.entities.Feed;
import com.github.lamarios.newsku.persistence.entities.FeedItem;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Collection;
import java.util.List;
import java.util.stream.Stream;

public interface FeedItemRepository extends JpaRepository<FeedItem, String> {
    FeedItem getFirstByGuid(String guid);

    @Query(value = "select i from FeedItem i where i.feed in :feeds and i.importance >= :minImportance and i.timeCreated > :from and i.timeCreated <= :to")
    Page<FeedItem> findallByTimeAndFeeds(@Param("minImportance") int minImportance, @Param("from") long from, @Param("to") long to, @Param("feeds") List<Feed> feeds, Pageable pageable);

    List<FeedItem> findFirstByIdAndFeedIn(String id, Collection<Feed> feeds);

    List<FeedItem> findByIdInAndFeedIn(Collection<String> ids, Collection<Feed> feeds);

    FeedItem getFirstByGuidAndFeed(String guid, Feed feed);

    FeedItem getFirstByIdAndFeedIn(String id, Collection<Feed> feeds);

    Page<FeedItem> findFeedItemByFeed(Feed feed, Pageable pageable);

    List<FeedItem> findAllByGuid(String guid);

    Stream<FeedItem> findAllByGuidInAndFeed(Collection<String> guids, Feed feed);

    @Query(value = """
            SELECT i.*
            FROM feed_items i
            WHERE feed_id IN :feeds
            AND i.search_terms @@ TO_TSQUERY('english', :query)
            GROUP BY i.id
            ORDER BY GREATEST(
                TS_RANK(i.search_terms, TO_TSQUERY('english', :query)),
                COALESCE(MAX(TS_RANK(i.search_terms, TO_TSQUERY('english', :query))), 0)
            ) DESC
            OFFSET :offset
            LIMIT :limit
            """, nativeQuery = true)
    List<FeedItem> search(@Param("query") String tsQuery, @Param("feeds") List<String> feeds, @Param("offset") int offset, @Param("limit") int limit);
}

package com.github.lamarios.newsku.services;

import com.github.lamarios.newsku.persistence.entities.Feed;
import com.github.lamarios.newsku.persistence.repositories.FeedRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class ScheduleService {
    private final FeedRepository feedRepository;
    private final FeedItemService feedItemService;

    @Autowired
    public ScheduleService(FeedRepository feedRepository, FeedItemService feedItemService) {
        this.feedRepository = feedRepository;
        this.feedItemService = feedItemService;
    }

    @Scheduled(fixedRate = 1000 * 60 * 60)
    public void refreshFeeds() {
        var feeds = feedRepository.findAll();
        for (Feed feed : feeds) {
            feedItemService.refreshFeed(feed);
        }
    }
}

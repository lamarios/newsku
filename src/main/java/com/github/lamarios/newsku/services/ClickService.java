package com.github.lamarios.newsku.services;

import com.github.lamarios.newsku.models.FeedClickStat;
import com.github.lamarios.newsku.models.TagClickStat;
import com.github.lamarios.newsku.persistence.entities.Feed;
import com.github.lamarios.newsku.persistence.entities.FeedClick;
import com.github.lamarios.newsku.persistence.entities.TagClick;
import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.persistence.repositories.FeedClicksRepository;
import com.github.lamarios.newsku.persistence.repositories.FeedRepository;
import com.github.lamarios.newsku.persistence.repositories.TagClicksRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ClickService {
    private final TagClicksRepository tagClicksRepository;
    private final UserService userService;
    private final FeedRepository feedRepository;
    private final FeedClicksRepository feedClicksRepository;

    @Autowired
    public ClickService(
            TagClicksRepository tagClicksRepository,
            UserService userService,
            FeedRepository feedRepository,
            FeedClicksRepository feedClicksRepository
    ) {
        this.tagClicksRepository = tagClicksRepository;
        this.userService = userService;
        this.feedRepository = feedRepository;
        this.feedClicksRepository = feedClicksRepository;
    }

    @Transactional(readOnly = true)
    public List<TagClickStat> tagClicks(long from, long to, User user) {
        List<TagClick> clicks = tagClicksRepository.findTagClickByUserAndTimeCreatedBetween(user, from, to);

        var grouped = clicks.stream().collect(Collectors.groupingBy(TagClick::getTag, Collectors.counting()));

        List<TagClickStat> clickList = new ArrayList<>();

        grouped.forEach((tag, count) -> clickList.add(new TagClickStat(tag, count)));
        return clickList;
    }

    @Transactional(readOnly = true)
    public List<TagClickStat> tagClicks(long from, long to) {
        return tagClicks(from, to, userService.getCurrentUser());
    }

    @Transactional(readOnly = true)
    public List<FeedClickStat> feedClicks(long from, long to) {
        List<Feed> feeds = feedRepository.getFeedsByUser(userService.getCurrentUser());

        List<FeedClick> clicks = feedClicksRepository.getAllByFeedInAndTimeCreatedBetween(feeds, from, to);

        var grouped = clicks.stream().collect(Collectors.groupingBy(FeedClick::getFeed, Collectors.counting()));

        List<FeedClickStat> clickList = new ArrayList<>();
        grouped.forEach((feed, count) -> clickList.add(new FeedClickStat(feed, count)));
        return clickList;
    }
}

package com.github.lamarios.newsku.services;

import static java.lang.Math.max;

import com.apptasticsoftware.rssreader.Enclosure;
import com.apptasticsoftware.rssreader.Item;
import com.github.lamarios.newsku.models.FeedToImport;
import com.github.lamarios.newsku.persistence.entities.*;
import com.github.lamarios.newsku.persistence.repositories.*;
import com.github.lamarios.newsku.utils.BackgroundTasks;
import com.github.lamarios.newsku.utils.HtmlUtils;
import com.github.lamarios.newsku.utils.TransactionHelper;
import jakarta.persistence.EntityManager;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.apache.commons.text.StringEscapeUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jetbrains.annotations.NotNull;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.Transactional;

@Service
public class FeedItemService {
  private static final Logger logger = LogManager.getLogger();
  // 30 days
  private static final long PROMPT_TAG_TIME_FRAME = 30 * 24 * 60 * 60 * 1000L;
  private final FeedItemRepository feedItemRepository;
  private final PlatformTransactionManager transactionManager;
  private final OpenaiService openaiService;
  private final UserService userService;
  private final EntityManager entityManager;
  private final FeedRepository feedRepository;
  private final FeedErrorRepository feedErrorRepository;
  private final FeedClicksRepository feedClicksRepository;
  private final TagClicksRepository tagClicksRepository;
  private final ClickService clickService;

  @Autowired
  public FeedItemService(
      FeedItemRepository feedItemRepository,
      PlatformTransactionManager transactionManager,
      OpenaiService openaiService,
      UserService userService,
      EntityManager entityManager,
      FeedRepository feedRepository,
      FeedErrorRepository feedErrorRepository,
      FeedClicksRepository feedClicksRepository,
      TagClicksRepository tagClicksRepository,
      ClickService clickService) {
    this.feedItemRepository = feedItemRepository;
    this.transactionManager = transactionManager;
    this.openaiService = openaiService;
    this.userService = userService;
    this.entityManager = entityManager;
    this.feedRepository = feedRepository;
    this.feedErrorRepository = feedErrorRepository;
    this.feedClicksRepository = feedClicksRepository;
    this.tagClicksRepository = tagClicksRepository;
    this.clickService = clickService;
  }

  public void refreshFeed(Feed feed) {
    BackgroundTasks.submitBackgroundTask(() -> refreshFeedWorker(feed));
  }

  public void refreshFeedWorker(Feed feed) {
    int errors = 0;
    try {
      logger.info("Refreshing feed {}", feed.getId());

      List<Item> items =
          FeedService.DEFAULT_READER
              .read(feed.getUrl())
              .sorted()
              .filter(item -> item.getGuid().isPresent())
              .collect(Collectors.toList());
      // we remove stuff that we already processed
      TransactionHelper.doInNewTransaction(
          transactionManager,
          true,
          () -> {
            List<String> guidsFromFeedUrl =
                items.stream()
                    .map(Item::getGuid)
                    .filter(Optional::isPresent)
                    .map(Optional::get)
                    .toList();
            if (guidsFromFeedUrl.isEmpty()) {
              return;
            }
            feedItemRepository
                .findAllByGuidInAndFeed(guidsFromFeedUrl, feed)
                .map(FeedItem::getGuid)
                .forEach(
                    s -> {
                      var removed =
                          items.removeIf(item -> item.getGuid().get().equalsIgnoreCase(s));
                      if (removed) {
                        logger.info("Feed {} already processed", s);
                      }
                    });
          });

      for (Item item : items) {
        try {
          TransactionHelper.doInNewTransaction(
              transactionManager,
              false,
              () -> {
                if (item.getGuid().isEmpty()) {
                  return;
                }

                try {
                  //                            var existingFeed =
                  // feedItemRepository.getFirstByGuidAndFeed(item.getGuid().get(), feed);
                  Optional<String> image =
                      item.getEnclosure()
                          .filter(
                              e ->
                                  e.getType() != null
                                      && e.getUrl() != null
                                      && e.getType().contains("image"))
                          .map(Enclosure::getUrl);

                  String imageUrl = image.orElse(getImageUrl(item));
                  /*
                                              if (existingFeed != null) {
                                                  logger.info("Feed {} already processed", item.getGuid().get());
                                                  return;
                                              }
                  */
                  var clicks =
                      clickService.tagClicks(
                          System.currentTimeMillis() - PROMPT_TAG_TIME_FRAME,
                          System.currentTimeMillis(),
                          feed.getUser());

                  var analysis = openaiService.processFeedItem(item, feed.getUser(), clicks);
                  if (analysis.isPresent()) {
                    FeedItem newItem = new FeedItem();
                    newItem.setId(UUID.randomUUID().toString());
                    newItem.setFeed(feed);
                    newItem.setUrl(item.getLink().orElse(null));
                    newItem.setGuid(item.getGuid().get());
                    newItem.setDescription(
                        item.getDescription()
                            .map(StringEscapeUtils::unescapeHtml4)
                            .map(HtmlUtils::getTextContent)
                            .orElse(null));
                    newItem.setTitle(
                        item.getTitle()
                            .map(StringEscapeUtils::unescapeHtml4)
                            .map(HtmlUtils::getTextContent)
                            .orElse(null));
                    newItem.setContent(
                        item.getContent()
                            .map(StringEscapeUtils::unescapeHtml4)
                            .map(HtmlUtils::getTextContent)
                            .orElse(null));
                    newItem.setImportance(analysis.get().importance());
                    newItem.setReasoning(analysis.get().reasoning());
                    newItem.setImageUrl(imageUrl);
                    newItem.setTimeCreated(
                        item.getPubDateAsZonedDateTime()
                            .map(zonedDateTime -> zonedDateTime.toInstant().toEpochMilli())
                            .orElse(System.currentTimeMillis()));
                    newItem.setTags(
                        analysis.get().tags().stream()
                            .map(String::toLowerCase)
                            .map(s -> s.replaceAll("[^a-zA-Z0-9 ]", ""))
                            .filter(s -> !s.isEmpty())
                            .toList());

                    feedItemRepository.save(newItem);
                  }
                } catch (Exception e) {
                  logger.error("Couldn't parse feed item: {}", item.getGuid(), e);
                  throw e;
                }
              });
        } catch (Exception e) {
          logger.error("Couldn't parse feed item: {}, top level catch", item.getGuid(), e);
          FeedError error = new FeedError();
          error.setId(UUID.randomUUID().toString());
          error.setTimeCreated(System.currentTimeMillis());
          error.setFeed(feed);
          error.setMessage(ExceptionUtils.getMessage(e));
          error.setError(ExceptionUtils.getStackTrace(e));
          if (item.getLink().isPresent()) {
            error.setUrl(item.getLink().get());
          }

          feedErrorRepository.save(error);

          errors++;
        }
      }
    } catch (Exception e) {
      logger.error("Couldn't parse feed: {}", feed.getUrl(), e);

      FeedError error = new FeedError();
      error.setId(UUID.randomUUID().toString());
      error.setTimeCreated(System.currentTimeMillis());
      error.setFeed(feed);
      error.setMessage(ExceptionUtils.getMessage(e));
      error.setError(ExceptionUtils.getStackTrace(e));
      feedErrorRepository.save(error);
      errors++;
    }

    feed.setLastRefreshErrors(errors);
    feedRepository.save(feed);
  }

  private String getImageUrl(Item item) {
    String imageUrl = null;
    if (item.getDescription().isPresent()) {
      Document doc = Jsoup.parse(item.getDescription().get());
      imageUrl = doc.getElementsByTag("img").attr("src");
    }

    if ((imageUrl == null || imageUrl.isBlank()) && item.getContent().isPresent()) {
      Document doc = Jsoup.parse(item.getContent().get());
      imageUrl = doc.getElementsByTag("img").attr("src");
    }
    // we don't want empty images or relative paths
    return Optional.ofNullable(imageUrl)
        .filter(s -> !s.isBlank() && !s.startsWith("/"))
        .orElse(getImageFromArticle(item));
  }

  /**
   * We'll try to get a twitter:image if there's any
   *
   * @param item which feed item to parse
   * @return a full url of a picture if it can be found
   */
  private String getImageFromArticle(Item item) {
    try {
      String imageUrl = null;
      if (item.getLink().isPresent()) {
        Document doc = Jsoup.connect(item.getLink().get()).timeout(5000).get();
        Element element = doc.selectFirst("meta[property=twitter:image]");
        if (element != null) {
          imageUrl = element.attr("content");
        }
        // we don't want empty images or relative paths
        if (imageUrl == null || imageUrl.isBlank()) {
          Element ogElement = doc.selectFirst("meta[property=og:image]");
          if (ogElement != null) {
            imageUrl = ogElement.attr("content");
          }
        }
      }
      return Optional.ofNullable(imageUrl)
          .filter(s -> !s.isBlank() && !s.startsWith("/"))
          .orElse(null);
    } catch (Exception e) {
      logger.error("Couldn't parse url from direct website", e);
      return null;
    }
  }

  @Transactional
  public void itemClicked(String id) {
    User user = userService.getCurrentUser();
    List<Feed> feeds = feedRepository.getFeedsByUser(user);
    FeedItem feedItem = feedItemRepository.getFirstByIdAndFeedIn(id, feeds);

    if (feedItem == null) {
      return;
    }

    FeedClick feedClick = new FeedClick();
    feedClick.setId(UUID.randomUUID().toString());
    feedClick.setFeed(feedItem.getFeed());
    feedClick.setTimeCreated(System.currentTimeMillis());
    feedClicksRepository.save(feedClick);

    for (String tag : feedItem.getTags()) {
      TagClick tagClick = new TagClick();
      tagClick.setId(UUID.randomUUID().toString());
      tagClick.setTag(tag);
      tagClick.setTimeCreated(System.currentTimeMillis());
      tagClick.setUser(user);
      tagClicksRepository.save(tagClick);
    }
  }

  @Transactional(readOnly = true)
  public Page<@NotNull FeedItem> getItems(Long from, Long to, int page, int pageSize) {
    List<Feed> feeds = feedRepository.getFeedsByUser(userService.getCurrentUser());
    var user = userService.getCurrentUser();

    return feedItemRepository.findallByTimeAndFeeds(
        user.getMinimumImportance(),
        from,
        to,
        feeds,
        PageRequest.of(
            page,
            pageSize,
            Sort.by(
                List.of(
                    new Sort.Order(Sort.Direction.DESC, "importance"),
                    new Sort.Order(Sort.Direction.DESC, "timeCreated")))));
  }

  @Transactional(readOnly = true)
  public List<FeedItem> search(String query, int page, int pageSize) {
    page = max(0, page);
    pageSize = max(pageSize, 1);

    String tsQuery =
        Arrays.stream(query.trim().split("\\s+"))
            .filter(s -> !s.isBlank())
            .map(s -> s.replaceAll("[^a-zA-Z0-9]", "") + ":*")
            .collect(Collectors.joining(" & "));

    var feeds =
        feedRepository.getFeedsByUser(userService.getCurrentUser()).stream()
            .map(Feed::getId)
            .toList();
    return feedItemRepository.search(tsQuery, feeds, page * pageSize, pageSize);
    //        return entityManager.createNativeQuery("SELECT * FROM feed_items WHERE search_terms @@
    // websearch_to_tsquery(:textQuery) AND feed_id IN :feeds LIMIT :pageSize OFFSET :page",
    // FeedItem.class).setParameter("textQuery", query).setParameter("feeds",
    // feeds.stream().map(Feed::getId).toList()).setParameter("pageSize",
    // pageSize).setParameter("page", page * pageSize).getResultList();
  }

  @Transactional(readOnly = true)
  public FeedItem getItem(String id) throws SQLException {
    List<Feed> feeds = feedRepository.getFeedsByUser(userService.getCurrentUser());

    return feedItemRepository.findFirstByIdAndFeedIn(id, feeds).stream().findFirst().orElse(null);
  }

  @Transactional
  public boolean readItems(List<String> ids) {
    var feeds = feedRepository.getFeedsByUser(userService.getCurrentUser());
    var items = feedItemRepository.findByIdInAndFeedIn(ids, feeds);

    items.forEach(feedItem -> feedItem.setRead(true));

    feedItemRepository.saveAll(items);

    return true;
  }

  @Transactional(readOnly = true)
  public Page<FeedItem> getFeedItems(String id, int page, int pageSize) {
    var feed = feedRepository.findFirstByIdAndUser(id, userService.getCurrentUser());
    if (feed == null) {
      return Page.empty();
    }
    Pageable pageable = PageRequest.of(page, pageSize, Sort.by("timeCreated").descending());
    return feedItemRepository.findFeedItemByFeed(feed, pageable);
  }

  @Transactional
  public void importFeed(FeedToImport feedToImport) {}
}

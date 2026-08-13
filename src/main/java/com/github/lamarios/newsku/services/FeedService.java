package com.github.lamarios.newsku.services;

import be.ceau.opml.OpmlParseException;
import be.ceau.opml.OpmlParser;
import be.ceau.opml.OpmlWriteException;
import be.ceau.opml.OpmlWriter;
import be.ceau.opml.entity.Body;
import be.ceau.opml.entity.Head;
import be.ceau.opml.entity.Opml;
import be.ceau.opml.entity.Outline;
import com.apptasticsoftware.rssreader.*;
import com.github.lamarios.newsku.Constants;
import com.github.lamarios.newsku.errors.NewskuException;
import com.github.lamarios.newsku.models.FeedToImport;
import com.github.lamarios.newsku.persistence.entities.Feed;
import com.github.lamarios.newsku.persistence.entities.FeedCategory;
import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.persistence.repositories.FeedCategoryRepository;
import com.github.lamarios.newsku.persistence.repositories.FeedRepository;
import com.github.lamarios.newsku.utils.BackgroundTasks;
import com.github.lamarios.newsku.utils.TemporaryInvalidXmlCharacterFilter;
import com.github.lamarios.newsku.utils.TransactionHelper;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Stream;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FeedService {
  private final UserService userService;
  private final FeedRepository feedRepository;
  private final Logger log = LogManager.getLogger();
  public static final AbstractRssReader<Channel, Item> DEFAULT_READER =
      new RssReader()
          .setUserAgent(Constants.USER_AGENT)
          .addFeedFilter(new TemporaryInvalidXmlCharacterFilter())
          .addItemExtension(
              "media:thumbnail",
              "url",
              (item, s) -> {
                Enclosure enclosure = new Enclosure();
                enclosure.setType("image");
                enclosure.setUrl(s);
                item.addEnclosure(enclosure);
              });
  private final FeedCategoriesService feedCategoriesService;
  private final FeedItemService feedItemService;
  private final PlatformTransactionManager transactionManager;
  private final FeedCategoryRepository feedCategoryRepository;

  @Autowired
  public FeedService(
      UserService userService,
      FeedRepository feedRepository,
      FeedCategoriesService feedCategoriesService,
      FeedItemService feedItemService,
      PlatformTransactionManager transactionManager,
      FeedCategoryRepository feedCategoryRepository) {
    this.userService = userService;
    this.feedRepository = feedRepository;
    this.feedCategoriesService = feedCategoriesService;
    this.feedItemService = feedItemService;
    this.transactionManager = transactionManager;
    this.feedCategoryRepository = feedCategoryRepository;
  }

  @Transactional
  public Feed addFeed(String url) throws NewskuException {
    return addFeed(url, null);
  }

  public Feed addFeed(String url, FeedCategory category) throws NewskuException {
    return addFeed(url, category, userService.getCurrentUser());
  }

  @Transactional
  public Feed addFeed(String url, FeedCategory category, User currentUser) throws NewskuException {
    log.info("Adding feed {} for category {}", url, category != null ? category.getName() : "n/a");

    List<Item> list;
    try {
      list = DEFAULT_READER.read(url).sorted().toList();
    } catch (Exception e) {
      throw new NewskuException("Couldn't read feed URL");
    }

    if (list.isEmpty()) {
      throw new NewskuException("Feed is empty");
    }

    var item = list.getFirst().getChannel();

    Feed feed = new Feed();
    feed.setId(UUID.randomUUID().toString());
    feed.setUrl(url);
    feed.setDescription(item.getDescription());
    feed.setImage(item.getImage().map(Image::getUrl).orElse(null));
    feed.setName(item.getTitle());
    feed.setUser(currentUser);
    feed.setCategory(category);

    return feedRepository.save(feed);
  }

  @Transactional(readOnly = true)
  public List<Feed> getFeeds() {
    return feedRepository.getFeedsByUser(userService.getCurrentUser());
  }

  @Transactional
  public Feed updateFeed(Feed feed) {
    var oldFeed = feedRepository.getFirstById(feed.getId());
    var user = userService.getCurrentUser();
    if (user.getId().equalsIgnoreCase(oldFeed.getUser().getId())) {
      feed.setUser(oldFeed.getUser());
      return feedRepository.save(feed);
    } else {
      throw new AccessDeniedException("you do not own this feed");
    }
  }

  @Transactional
  public boolean deleteFeed(String id) {
    Feed firstById = feedRepository.getFirstById(id);
    var user = userService.getCurrentUser();

    if (user.getId().equalsIgnoreCase(firstById.getUser().getId())) {
      feedRepository.delete(firstById);
      return true;
    }
    return false;
  }

  public Feed getFeed(String id) {
    return feedRepository.findFirstByIdAndUser(id, userService.getCurrentUser());
  }

  @Transactional
  public List<FeedToImport> getFeedsFromOpml(MultipartFile file) throws NewskuException {
    try {
      log.info("Importing feed");
      var user = userService.getCurrentUser();
      Path tempDirectory = Files.createTempDirectory("newsku-opml-import");
      Path p = tempDirectory.resolve("import.opml");
      file.transferTo(p);
      List<FeedToImport> newFeeds = new ArrayList<>();

      try (var is = new FileInputStream(p.toFile())) {
        var parser = new OpmlParser().parse(is);
        for (Outline outline : parser.getBody().getOutlines()) {
          newFeeds.addAll(getFeedsFromOpml(outline, user, null));
        }

        return newFeeds;
      } catch (SQLException | OpmlParseException e) {
        log.error("Failed to parse opml file", e);
        throw new NewskuException("Failed to parse OPML file");
      } finally {
        Files.deleteIfExists(p);
        Files.deleteIfExists(tempDirectory);
      }
    } catch (IOException e) {
      throw new NewskuException("Failed to read file");
    }
  }

  @Transactional
  public List<FeedToImport> getFeedsFromOpml(Outline outline, User user, FeedCategory category)
      throws SQLException, IOException, NewskuException {
    List<FeedToImport> newFeeds = new ArrayList<>();

    var existingCategories = feedCategoriesService.getCategories();
    Map<String, String> attributes = outline.getAttributes();
    FeedCategory childrenCategory = null;
    if (attributes.containsKey("type")
        && attributes.get("type").equalsIgnoreCase("rss")
        && attributes.containsKey("xmlUrl")) {
      // we check if the feed already exists
      String url = attributes.get("xmlUrl");
      if (feedRepository.findFirstByUrlAndUser(url, user).isEmpty()) {
        try {
          newFeeds.add(new FeedToImport(url, category));
        } catch (Exception e) {
          log.warn("Couldnt parse feed {}", url, e);
        }
      } else {
        log.info("User already has feed {}", url);
      }
    } else if (attributes.containsKey("text") || attributes.containsKey("title")) {
      // if it's not a feed url, it's a category
      String categoryName =
          attributes.containsKey("text") ? attributes.get("text") : attributes.get("title");
      List<FeedCategory> matchingCategories =
          existingCategories.stream()
              .filter(s -> s.getName().equalsIgnoreCase(categoryName))
              .toList();
      if (!matchingCategories.isEmpty()) {
        childrenCategory = matchingCategories.getFirst();
      } else {
        childrenCategory = feedCategoriesService.addCategory(categoryName);
      }
    }

    if (!outline.getSubElements().isEmpty()) {
      FeedCategory finalChildrenCategory = childrenCategory;
      outline
          .getSubElements()
          .forEach(
              outline1 -> {
                try {
                  newFeeds.addAll(getFeedsFromOpml(outline1, user, finalChildrenCategory));
                } catch (SQLException | IOException | NewskuException e) {
                  throw new RuntimeException(e);
                }
              });
    }

    return newFeeds;
  }

  private Outline getFeedOutline(Feed feed) {
    return new Outline(
        Map.of("type", "rss", "xmlUrl", feed.getUrl(), "title", feed.getName()),
        Collections.emptyList());
  }

  @Transactional(readOnly = true)
  public String exportFeed() throws OpmlWriteException {
    User currentUser = userService.getCurrentUser();
    var categories = feedCategoryRepository.getAllByUser(currentUser);

    List<Outline> outlines = new ArrayList<>();
    // split by category
    categories.forEach(
        cat -> {
          Map<String, String> catAttributes = Map.of("text", cat.getName(), "title", cat.getName());
          var children =
              feedRepository
                  .getFeedByUserAndCategory(currentUser, cat)
                  .map(this::getFeedOutline)
                  .toList();
          var outline = new Outline(catAttributes, children);
          outlines.add(outline);
        });

    var feeds = feedRepository.getFeedsByUser(currentUser);
    Stream<Feed> feedByUserAndNullCategory =
        feedRepository.getFeedByUserAndNullCategory(currentUser);
    outlines.addAll(feedByUserAndNullCategory.map(this::getFeedOutline).toList());

    Head head =
        new Head(
            "Newsku",
            LocalDateTime.now().toString(),
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null);

    Body body = new Body(outlines);

    Opml opml = new Opml("2.0", head, body);

    OpmlWriter writer = new OpmlWriter();

    return writer.write(opml);
  }

  @Transactional
  public void importFeed(FeedToImport feedToImport) {
    var currentUser = userService.getCurrentUser();
    BackgroundTasks.submitBackgroundTask(
        () -> {
          TransactionHelper.doInNewTransaction(
              transactionManager,
              false,
              () -> {
                try {
                  var feed = addFeed(feedToImport.url(), feedToImport.feedCategory(), currentUser);
                  feedItemService.refreshFeed(feed);
                } catch (NewskuException e) {
                  log.error("Couldn't import feed {}", feedToImport.url(), e);
                }
              });
        });
  }
}

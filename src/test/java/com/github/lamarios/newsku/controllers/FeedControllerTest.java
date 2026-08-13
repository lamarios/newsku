package com.github.lamarios.newsku.controllers;

import be.ceau.opml.OpmlParseException;
import be.ceau.opml.OpmlParser;
import com.github.lamarios.newsku.TestConfig;
import com.github.lamarios.newsku.TestContainerTest;
import com.github.lamarios.newsku.errors.NewskuException;
import com.github.lamarios.newsku.models.FeedToImport;
import com.github.lamarios.newsku.persistence.entities.Feed;
import com.github.lamarios.newsku.persistence.entities.FeedCategory;
import com.github.lamarios.newsku.persistence.entities.FeedItem;
import com.github.lamarios.newsku.persistence.repositories.FeedCategoryRepository;
import com.github.lamarios.newsku.persistence.repositories.FeedItemRepository;
import com.github.lamarios.newsku.persistence.repositories.FeedRepository;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.context.annotation.Import;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;
import org.testcontainers.shaded.org.checkerframework.checker.units.qual.A;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.SQLException;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;

@Import(TestConfig.class)
public class FeedControllerTest extends TestContainerTest {
    @Autowired
    private FeedController feedController;
    @Autowired
    private FeedRepository feedRepository;

    @Autowired
    private FeedCategoryController feedCategoryController;
    @Autowired
    private FeedCategoryRepository feedCategoryRepository;

    @LocalServerPort
    private int port;
    @Autowired
    private FeedItemRepository feedItemRepository;

    @AfterEach
    public void tearDown() {
        feedRepository.deleteAll();
        feedCategoryRepository.deleteAll();
    }

    @Test
    public void testFeedCrud() throws SQLException, NewskuException {
        String url = "http://localhost:" + port + "/test/rss/one-month-feed";

        var feed = feedController.addFeed(url, true);

        assertNotNull(feed);
        assertEquals(url, feed.getUrl());


        var feeds = feedController.getFeeds();
        assertEquals(1, feeds.size());

        var cat = feedCategoryController.addCategory("My cat");
        feed.setCategory(cat);
        feedController.updateFeed(feed);


        feeds = feedController.getFeeds();
        assertEquals(cat.getId(), feeds.getFirst().getCategory().getId());

        feedController.deleteFeed(feeds.getFirst().getId());

        feeds = feedController.getFeeds();

        assertEquals(0, feeds.size());
    }

    @Test
    public void testAddingInvalidFeed() {
        assertThrows(NewskuException.class, () -> feedController.addFeed("somegarbageurl"));
    }

    @Test
    public void testImportFeeds() throws NewskuException, IOException {
        ClassLoader classloader = Thread.currentThread().getContextClassLoader();
        try (InputStream is = classloader.getResourceAsStream("feeds.opml")) {
            MultipartFile file = new MockMultipartFile("file", "feeds.opml", "text/plain", is);
            var feeds = feedController.importFeed(file);
            assertEquals(2, feeds.size());
        }
    }

    @Test
    public void testImportFeedsWithCategories() throws NewskuException, IOException {
        ClassLoader classloader = Thread.currentThread().getContextClassLoader();
        try (InputStream is = classloader.getResourceAsStream("feeds_with_categories.opml")) {
            MultipartFile file = new MockMultipartFile("file", "feeds.opml", "text/plain", is);
            var feeds = feedController.importFeed(file);
            assertEquals(2, feeds.size());

            List<FeedCategory> categories = feeds.stream().map(FeedToImport::feedCategory).filter(Objects::nonNull).toList();
            assertEquals(2, categories.size());
            assertTrue(categories.stream().map(FeedCategory::getName).anyMatch(c -> c.equalsIgnoreCase("Subscriptions")));
            assertTrue(categories.stream().map(FeedCategory::getName).anyMatch(c -> c.equalsIgnoreCase("Comics")));

            // we need to make sure that the categories were properly created in the database
            var dbCategories = feedCategoryController.getCategories();
            assertEquals(2, dbCategories.size());
            assertTrue(dbCategories.stream().map(FeedCategory::getName).anyMatch(c -> c.equalsIgnoreCase("Subscriptions")));
            assertTrue(dbCategories.stream().map(FeedCategory::getName).anyMatch(c -> c.equalsIgnoreCase("Comics")));
        }
    }

    @Test
    public void testImportInvalidOPML() throws IOException {
        ClassLoader classloader = Thread.currentThread().getContextClassLoader();
        try (InputStream is = classloader.getResourceAsStream("rubish_feeds.opml")) {
            MultipartFile file = new MockMultipartFile("file", "feeds.opml", "text/plain", is);
            assertThrows(NewskuException.class, () -> feedController.importFeed(file));
        }
    }


    @Test
    public void testExportFeeds() throws IOException, OpmlParseException, NewskuException {
        testImportFeeds();


        var response = feedController.exportFeeds();


        var file = Files.createTempFile("newskutest", ".opml");

        try (FileOutputStream fos = new FileOutputStream(file.toAbsolutePath().toString())) {
            assert response.getBody() != null;
            response.getBody().writeTo(fos);

            assertTrue(Files.exists(file.toAbsolutePath()));
            assertTrue(Files.isRegularFile(file));
            assertTrue(Files.size(file) > 0);


        }

        try (var is = new FileInputStream(file.toAbsolutePath().toFile())) {
            var parser = new OpmlParser().parse(is);
            assertEquals(2, parser.getBody().getOutlines().size());
        }
    }


    @Test
    public void testGettingSingleFeedItems() throws NewskuException, IOException {
        testImportFeeds();

        var userFeeds = feedController.getFeeds();
        assertEquals(2, userFeeds.size());

        FeedItem i1 = new FeedItem();
        i1.setId(UUID.randomUUID().toString());
        i1.setFeed(userFeeds.getFirst());
        i1.setGuid("a1");
        i1.setTitle("t1");
        i1.setContent("c1");
        i1.setDescription("d1");
        i1.setTimeCreated(System.currentTimeMillis());
        feedItemRepository.save(i1);

        FeedItem i2 = new FeedItem();
        i2.setId(UUID.randomUUID().toString());
        i2.setFeed(userFeeds.getFirst());
        i2.setGuid("a2");
        i2.setTitle("t2");
        i2.setContent("c2");
        i2.setDescription("d2");
        i2.setTimeCreated(System.currentTimeMillis());
        feedItemRepository.save(i2);

        var page = feedController.getFeedItems(userFeeds.getFirst().getId(), 0, 1);
        assertEquals(2, page.getTotalPages());
        assertEquals(1, page.getContent().size());
        assertEquals(2, page.getTotalElements());

    }
}

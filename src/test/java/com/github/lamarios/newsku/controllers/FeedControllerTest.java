package com.github.lamarios.newsku.controllers;

import be.ceau.opml.OpmlParseException;
import be.ceau.opml.OpmlParser;
import com.github.lamarios.newsku.TestConfig;
import com.github.lamarios.newsku.TestContainerTest;
import com.github.lamarios.newsku.errors.NewskuException;
import com.github.lamarios.newsku.persistence.repositories.FeedCategoryRepository;
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
}

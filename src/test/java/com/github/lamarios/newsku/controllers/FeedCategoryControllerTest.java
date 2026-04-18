package com.github.lamarios.newsku.controllers;

import com.github.lamarios.newsku.TestConfig;
import com.github.lamarios.newsku.TestContainerTest;
import com.github.lamarios.newsku.errors.NewskuException;
import com.github.lamarios.newsku.persistence.repositories.FeedCategoryRepository;
import com.github.lamarios.newsku.persistence.repositories.FeedRepository;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Import;

import static org.junit.jupiter.api.Assertions.*;

@Import(TestConfig.class)
public class FeedCategoryControllerTest extends TestContainerTest {
    @Autowired
    private FeedCategoryController feedCategoryController;
    @Autowired
    private FeedCategoryRepository feedCategoryRepository;

    @AfterEach
    public void tearDown() {
        feedCategoryRepository.deleteAll();
    }

    @Test
    public void testFeedCategoryCrud() throws NewskuException {
        var zCat = feedCategoryController.addCategory("Z");
        var aCat = feedCategoryController.addCategory("A");

        // test if feeds exists
        // test if the main getter gets feed in order
        assertNotNull(zCat);
        assertNotNull(aCat);

        // the categories should be ordered alphabetically
        var feeds = feedCategoryController.getCategories();
        assertEquals(aCat.getName(), feeds.getFirst().getName());
        assertEquals(zCat.getName(), feeds.getLast().getName());


        aCat.setName("AAA");
        var updated = feedCategoryController.updateCategory(aCat);
        assertEquals("AAA", updated.getName());

        feeds = feedCategoryController.getCategories();
        assertEquals("AAA", feeds.getFirst().getName());


        feedCategoryController.deleteCategory(zCat.getId());

        feeds = feedCategoryController.getCategories();
        assertEquals(1, feeds.size());
        assertEquals("AAA", feeds.getFirst().getName());
    }

    @Test
    public void testAddingFeedWithNoName(){
        assertThrows(NewskuException.class, () -> feedCategoryController.addCategory(null));
        assertThrows(NewskuException.class, () -> feedCategoryController.addCategory(""));
    }
}

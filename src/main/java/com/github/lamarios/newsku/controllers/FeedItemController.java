package com.github.lamarios.newsku.controllers;

import com.github.lamarios.newsku.persistence.entities.FeedItem;
import com.github.lamarios.newsku.services.FeedItemService;
import com.github.lamarios.newsku.utils.ImageHelper;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.InvalidParameterException;
import java.sql.SQLException;
import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.bind.DefaultValue;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody;

@RestController
@RequestMapping("/api/feeds/items")
@Tag(name = "Feeds")
@SecurityRequirement(name = "bearerAuth")
public class FeedItemController {
    private final FeedItemService feedItemService;
    private final Logger log = LogManager.getLogger();
    private final Path tempDir;

    @Autowired
    public FeedItemController(FeedItemService feedItemService) throws IOException {
        this.feedItemService = feedItemService;
        this.tempDir = Files.createTempDirectory("newsku-feed-item-images-");
    }

    @GetMapping
    public Page<FeedItem> getItems(
            @RequestParam("from") Long from,
            @RequestParam("to") Long to,
            @DefaultValue("0") @RequestParam("page") int page,
            @DefaultValue("100") @RequestParam("pageSize") int pageSize
    ) throws SQLException {
        if (from == null || to == null) {
            throw new InvalidParameterException("from and to query parameters are required");
        }
        return feedItemService.getItems(from, to, page, pageSize);
    }

    @PostMapping("/read")
    public boolean readArticles(@RequestBody List<String> ids) {
        log.info("Changing read status of {} items", ids.size());
        return feedItemService.readItems(ids);
    }

    @PutMapping("/{id}/click")
    public void clickItem(@PathVariable String id) {
        feedItemService.itemClicked(id);
    }

    @GetMapping("/{id}/image")
    public ResponseEntity<StreamingResponseBody> getArticleImage(@PathVariable String id)
            throws IOException,
            SQLException {
        var item = feedItemService.getItem(id);

        if (item == null || item.getImageUrl() == null || item.getImageUrl().isBlank()) {
            return ResponseEntity.status(404).build();
        }

        var filePath = tempDir.resolve(id);

        if (!filePath.toFile().exists()) {
            log.info("File doesn't exist in cache, caching it...");
            ImageHelper.downloadImageToPath(item.getImageUrl(), filePath);
        } else {
            log.info("Serving from cache");
        }
        // Fetch from remote URL
        return serveFile(filePath);
    }

    public static ResponseEntity<StreamingResponseBody> serveFile(Path filePath) throws IOException {
        String contentType = Files.probeContentType(filePath);
        if (contentType == null) {
            contentType = "application/octet-stream";
        }

        long fileSize = Files.size(filePath);

        StreamingResponseBody responseBody =
                outputStream -> {
            try (InputStream inputStream = new FileInputStream(filePath.toFile())) {
                // 8KB buffer
                byte[] buffer = new byte[8192];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
                outputStream.flush();
            }
        };

        return ResponseEntity
            .ok()
            .header(HttpHeaders.CONTENT_TYPE, contentType)
            .header(HttpHeaders.CONTENT_LENGTH, String.valueOf(fileSize))
            .body(responseBody);
    }
}

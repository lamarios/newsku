package com.github.lamarios.newsku.controllers;

import com.github.lamarios.newsku.persistence.entities.Feed;
import com.github.lamarios.newsku.persistence.entities.FeedItem;
import com.github.lamarios.newsku.persistence.repositories.FeedItemRepository;
import com.github.lamarios.newsku.persistence.repositories.FeedRepository;
import com.github.lamarios.newsku.utils.ImageHelper;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Optional;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody;

@RestController()
@RequestMapping("/images")
public class ImageController {

  private final Path tempDir;
  private final Logger log = LogManager.getLogger();

  private final FeedRepository feedRepository;
  private final FeedItemRepository feedItemRepository;

  @Autowired
  public ImageController(FeedRepository feedRepository, FeedItemRepository feedItemRepository)
      throws IOException {
    this.feedRepository = feedRepository;
    this.tempDir = Files.createTempDirectory("newsku-feed-images");
    this.feedItemRepository = feedItemRepository;
  }

  @GetMapping("feeds/{id}")
  public ResponseEntity<@NotNull StreamingResponseBody> getFeedImage(@PathVariable String id)
      throws IOException {
    return getImage(id, feedRepository.findById(id).map(Feed::getImage));
  }

  @GetMapping("feeds/items/{id}")
  public ResponseEntity<StreamingResponseBody> getArticleImage(@PathVariable String id)
      throws IOException {
    return getImage(id, feedItemRepository.findById(id).map(FeedItem::getImageUrl));
  }

  private ResponseEntity<StreamingResponseBody> getImage(String id, Optional<String> item)
      throws IOException {

    if (item.filter(s -> !s.isBlank()).isEmpty()) {
      return ResponseEntity.status(404).build();
    }

    var filePath = tempDir.resolve(id);

    if (!filePath.toFile().exists()) {
      log.info("File doesn't exist in cache, caching it...");
      ImageHelper.downloadImageToPath(item.get(), filePath);
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

    return ResponseEntity.ok()
        .header(HttpHeaders.CONTENT_TYPE, contentType)
        .header(HttpHeaders.CONTENT_LENGTH, String.valueOf(fileSize))
        .body(responseBody);
  }
}

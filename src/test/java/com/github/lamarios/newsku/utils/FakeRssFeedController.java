package com.github.lamarios.newsku.utils;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import java.util.UUID;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/test/rss")
public class FakeRssFeedController {
  private final DateTimeFormatter formatter =
      DateTimeFormatter.ofPattern("EEE, d MMM yyyy HH:mm:ss Z", Locale.ENGLISH);

  @GetMapping("/one-month-feed")
  public String oneMonthFeed() {
    StringBuilder items = new StringBuilder();
    // we generate 31 days of articles
    ZonedDateTime now = ZonedDateTime.now();

    for (int i = 0; i < 31; i++) {
      items.append(generateItem(now.minusDays(i)));
    }

    return """
                <?xml version="1.0" encoding="UTF-8" standalone="no"?>
                <rss xmlns:atom="http://www.w3.org/2005/Atom" xmlns:content="http://purl.org/rss/1.0/modules/content/"
                     xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:media="http://search.yahoo.com/mrss/"
                     xmlns:slash="http://purl.org/rss/1.0/modules/slash/" xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
                     version="2.0">
                    <channel>
                        <title>Newsku test feed</title>
                        <link>http://localhost:8080/test/rss/one-month-feed</link>
                        <description>Newsku unit test feed</description>
                        <lastBuildDate>%s</lastBuildDate>
                        <language>en-US</language>
                        %s
                    </channel>
                </rss>
                """
        .formatted(formatter.format(ZonedDateTime.now()), items.toString());
  }

  private String generateItem(ZonedDateTime time) {
    String id = UUID.randomUUID().toString();
    return """
                       <item>
                            <title>Newsku unit test article %s</title>
                            <link>http://localhost/test/somearticle-%s</link>

                            <pubDate>%s</pubDate>
                            <guid isPermaLink="true">
                                %s
                            </guid>

                            <description>
                                Some Rss article
                            </description>
                        </item>
                """
        .formatted(formatter.format(time), id, formatter.format(time), id);
  }
}

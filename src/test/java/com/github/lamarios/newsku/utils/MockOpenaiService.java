package com.github.lamarios.newsku.utils;

import com.apptasticsoftware.rssreader.Item;
import com.github.lamarios.newsku.models.OpenAiFeedResponse;
import com.github.lamarios.newsku.models.TagClickStat;
import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.services.OpenaiService;
import java.util.List;
import java.util.Optional;
import java.util.Random;
import org.springframework.context.annotation.Primary;

// @Primary
// @Service
public class MockOpenaiService implements OpenaiService {
    @Primary
    @Override
    public Optional<OpenAiFeedResponse> processFeedItem(Item item, User user, List<TagClickStat> clickStats) {
        return Optional.of(
                new OpenAiFeedResponse(new Random().nextInt(100), false, "This is a test", List.of("my", "tags"))
        );
    }
}

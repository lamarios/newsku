package com.github.lamarios.newsku.services;

import com.apptasticsoftware.rssreader.Item;
import com.github.lamarios.newsku.models.OpenAiFeedResponse;
import com.github.lamarios.newsku.models.TagClickStat;
import com.github.lamarios.newsku.persistence.entities.User;
import java.util.List;
import java.util.Optional;

public interface OpenaiService {
  Optional<OpenAiFeedResponse> processFeedItem(Item item, User user, List<TagClickStat> clickStats);
}

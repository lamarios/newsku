package com.github.lamarios.newsku.models;

import com.github.lamarios.newsku.persistence.entities.Feed;

public record FeedClickStat(Feed feed, long clicks) {}

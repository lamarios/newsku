package com.github.lamarios.newsku.models;

import com.github.lamarios.newsku.persistence.entities.FeedCategory;

public record FeedToImport(String url, FeedCategory feedCategory) {}

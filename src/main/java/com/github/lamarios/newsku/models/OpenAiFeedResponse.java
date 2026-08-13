package com.github.lamarios.newsku.models;

import java.util.List;

public record OpenAiFeedResponse(int importance, boolean possibleAd, String reasoning, List<String> tags) {}

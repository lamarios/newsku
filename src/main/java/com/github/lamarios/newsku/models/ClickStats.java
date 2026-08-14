package com.github.lamarios.newsku.models;

import java.util.List;

public record ClickStats(List<TagClickStat> tagClicks, List<FeedClickStat> feedClicks) {}

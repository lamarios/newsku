package com.github.lamarios.newsku.services;

import com.apptasticsoftware.rssreader.Item;
import com.github.lamarios.newsku.models.OpenAiFeedResponse;
import com.github.lamarios.newsku.models.TagClickStat;
import com.github.lamarios.newsku.persistence.entities.User;
import com.openai.client.OpenAIClient;
import com.openai.client.okhttp.OpenAIOkHttpClient;
import com.openai.models.ReasoningEffort;
import com.openai.models.chat.completions.ChatCompletionCreateParams;
import com.openai.models.chat.completions.StructuredChatCompletionCreateParams;
import com.openai.models.models.Model;
import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service("openaiService")
public class OpenaiServiceImpl implements OpenaiService {
  private static final Logger logger = LogManager.getLogger();
  private final String url;
  private final String apiKey;
  private final String model;

  @Autowired
  public OpenaiServiceImpl(
      @Value("${OPENAI_URL}") String url,
      @Value("${OPENAI_API_KEY:}") String apiKey,
      @Value("${OPENAI_MODEL}") String model) {
    this.url = url;
    this.apiKey = apiKey;
    this.model = model;

    var models = getClient().models().list();
    List<String> modelList = new ArrayList<>();
    while (models.hasNextPage() || !models.data().isEmpty()) {
      modelList.addAll(models.data().stream().map(Model::id).toList());
      if (models.hasNextPage()) {
        models = models.nextPage();
      } else {
        break;
      }
    }

    logger.info("Available models: {}", String.join(",", modelList));
    if (!modelList.contains(model)) {
      throw new RuntimeException("Model " + model + " not available");
    }
  }

  private OpenAIClient getClient() {
    var client = OpenAIOkHttpClient.builder().baseUrl(url).checkJacksonVersionCompatibility(false);

    if (apiKey != null && !apiKey.trim().isBlank()) {
      client = client.apiKey(apiKey);
    }

    client.timeout(Duration.ofMinutes(2));

    return client.build();
  }

  public Optional<OpenAiFeedResponse> processFeedItem(
      Item item, User user, List<TagClickStat> clickStats) {
    String tagPrompt =
        """
                          These are the tags the user clicked on the most in the past 30 days ordered from the most clicked to the least clicked. Those tags may slightly affect your scoring:
                          %s
                        """
            .formatted(
                clickStats.stream()
                    .sorted((o1, o2) -> Long.compare(o2.clicks(), o1.clicks()))
                    .limit(10)
                    .map(s -> "%s (%d clicks)".formatted(s.tag(), s.clicks()))
                    .collect(Collectors.joining(", ")));

    var start = System.currentTimeMillis();
    String prompt =
        """
                        Your task is to identify is this news item is important or not
                        you will rate the importance from 0 to a 100, 100 being the most important, be very granular in the rating
                        Keep in mind that this is a ranking system for a RSS feed reader so the user might have 100s of news on a daily basis so do not be too eager on overrating news
                        also you will try to figure out if this feed item is an ad or not

                        You will use the name and description of the source to understand what an important news is for a user.
                        You will also tag the article with up to 4 tags

                        The user has the following preferences. You will refer to it to figure out how to rate a news item:
                        %s

                        %s

                        Here is the news item:

                        title: %s
                        content: %s

                        """
            .formatted(
                Optional.ofNullable(user.getFeedItemPreference())
                    .filter(s -> !s.isBlank())
                    .orElse("The user has no particular preferences"),
                clickStats.isEmpty() ? "" : tagPrompt,
                item.getTitle().orElse("no title"),
                item.getDescription()
                    .filter(s -> !s.isBlank())
                    .orElse(item.getContent().orElse("no content")));
    /*
            System.out.printf("""
                    GUID: %s
                    =====================================
                    %s
                    """, item.getGuid(), prompt);
    */
    StructuredChatCompletionCreateParams<OpenAiFeedResponse> params =
        ChatCompletionCreateParams.builder()
            .addUserMessage(prompt)
            .model(model)
            .reasoningEffort(ReasoningEffort.NONE)
            .responseFormat(OpenAiFeedResponse.class)
            .build();

    List<OpenAiFeedResponse> analysis =
        getClient().chat().completions().create(params).choices().stream()
            .flatMap(choice -> choice.message().content().stream())
            .toList();

    Optional<OpenAiFeedResponse> first = analysis.stream().findFirst();
    first.ifPresent(
        openAiFeedResponse ->
            logger.info(
                "Analysis results for feed item: {}:\nimportance: {}\npossible ad: {}\nreasoning: {}\ntags: {}\ntime: {}s",
                item.getGuid(),
                openAiFeedResponse.importance(),
                openAiFeedResponse.possibleAd(),
                openAiFeedResponse.reasoning(),
                String.join(",", openAiFeedResponse.tags()),
                (System.currentTimeMillis() - start) / 1000));
    return first;
  }
}

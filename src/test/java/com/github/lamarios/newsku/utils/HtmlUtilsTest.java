package com.github.lamarios.newsku.utils;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class HtmlUtilsTest {
    @Test
    public void testHtmlToText() {
        var html =
                """
                <img src="https://assetsio.gnwcdn.com/stalker-2-stories-untold-update-01.jpg?width=690&quality=85&format=jpg&auto=webp" /> <p><strong>Update to the update:</strong> Oop, it's <a href="https://store.steampowered.com/news/app/1643320/view/519732795817328984">out now</a>, on December 17th. So, GSC have delivered <a href="https://www.rockpapershotgun.com/games/stories-untold">Stories Untold</a> a day early, but also a day late. Cool. Here's a <a href="https://www.youtube.com/watch?v=5qdv38i67U0">new trailer</a>, too.</p>
                <p>Update: You'll have to wait a bit longer to see what that radio signal's all about. "Due to the last-minute complications, we have to delay the Stories Untold update by a couple of days," GSC have <a href="https://x.com/stalker_thegame/status/2000934643156082732">posted</a> alongside a GIF of a dude throwing some medical equipment. The update's now set to arrive this Thursday, December 18th.</p>
                <p>Original story follows:</p>
                <p><a href="https://www.rockpapershotgun.com/stalker-2-best-guns">Stalker 2</a>'s getting a bunch of new quests just in time for the holidays, with an update dubbed Stories Untold sending you off to investigate a mysterious headache-inducing radio signal when it arrives tomorrow, December 16th. There'll also be a new hub area in the Burnt Forest and a new suppressed rifle for you to fiddle with as you chill by the campfire.</p>
                 <p><a href="https://www.rockpapershotgun.com/stalker-2s-stories-untold-update-delivers-a-new-questline-and-a-place-to-chill-in-the-burnt-forest-this-week">Read more</a></p>
                """;

        var text = HtmlUtils.getTextContent(html);
        Assertions.assertEquals(
                "Update to the update: Oop, it's out now, on December 17th. So, GSC have delivered Stories "
                + "Untold a day early, but also a day late. Cool. Here's a new trailer, too. Update: You'll "
                + "have to wait a bit longer to see what that radio signal's all about. \\\"Due to the last-"
                + "minute complications, we have to delay the Stories Untold update by a couple of days,\\\" "
                + "GSC have posted alongside a GIF of a dude throwing some medical equipment. The update's "
                + "now set to arrive this Thursday, December 18th. Original story follows: Stalker 2's "
                + "getting a bunch of new quests just in time for the holidays, with an update dubbed "
                + "Stories Untold sending you off to investigate a mysterious headache-inducing radio signal "
                + "when it arrives tomorrow, December 16th. There'll also be a new hub area in the Burnt "
                + "Forest and a new suppressed rifle for you to fiddle with as you chill by the campfire. "
                + "Read more",
                text
        );
    }
}

package com.github.lamarios.newsku.utils;

import static org.awaitility.Awaitility.await;
import java.util.concurrent.TimeUnit;

public class BackgroundTaskUtils {
    public static void waitForTasksToFinish() {
        // since adding feeds will create lots of background tasks
        // we make sure that there is not pending stuff when we proceed with a new test
        await()
            .atMost(5, TimeUnit.MINUTES)
            .pollInterval(50, TimeUnit.MILLISECONDS)
            .until(() -> BackgroundTasks.getInFlight().get() == 0);
    }
}

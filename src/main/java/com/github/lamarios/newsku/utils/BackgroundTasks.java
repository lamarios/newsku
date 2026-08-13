package com.github.lamarios.newsku.utils;

import java.util.concurrent.Future;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicLong;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class BackgroundTasks {
  private static final Logger logger = LogManager.getLogger();
  private static final AtomicLong IN_FLIGHT = new AtomicLong(0);
  private static final ThreadPoolExecutor BACKGROUND_TASKS =
      new ThreadPoolExecutor(1, 1, 0L, TimeUnit.MILLISECONDS, new LinkedBlockingQueue<Runnable>());

  public static Future<?> submitBackgroundTask(Runnable task) {
    var inFlight = IN_FLIGHT.incrementAndGet();
    logger.info("Submitting background tasks, in flight: {}", inFlight);
    return BACKGROUND_TASKS.submit(
        () -> {
          try {
            task.run();
          } finally {
            var inFlightAfter = IN_FLIGHT.decrementAndGet();
            logger.info("Done with task, {} remaining", inFlightAfter);
          }
        });
  }

  public static AtomicLong getInFlight() {
    return IN_FLIGHT;
  }
}

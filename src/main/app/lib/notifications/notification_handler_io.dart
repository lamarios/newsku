import 'dart:io';
import 'dart:ui';

import 'package:app/feed/services/feed_service.dart';
import 'package:app/l10n/app_localizations_en.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

final _log = Logger('NotificationHandler');

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    _log.info('Executing task $taskName');
    switch (taskName) {
      case 'check-notifications':
        await NotificationHandler.checkNewFeedItems();
        break;
    }

    return Future.value(true);
  });
}

class NotificationHandler {
  static String newItemsChannel = 'new-items';

  static Future<void> initNotifications() async {
    await AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
          channelKey: newItemsChannel,
          channelName: 'New RSS feed items',
          channelDescription: 'Tells you how many new items since your last used the app',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
      ],
      // Channel groups are only visual and are not required
      debug: kDebugMode,
    );

    _log.fine("Notifications initialized");
  }

  static Future<void> initialize() async {
    if (!kIsWeb && Platform.isAndroid) {
      await Workmanager().initialize(callbackDispatcher);
      _log.fine("Work manager initialized");
      await initNotifications();
    }
  }

  static void testWorkmanager() {
    Workmanager().registerOneOffTask('test-notifications', 'check-notifications');
  }

  static Future<void> checkNewFeedItems() async {
    await NotificationHandler.initNotifications();

    var prefs = await SharedPreferences.getInstance();
    var server = prefs.getString('server');
    var lastSync = prefs.getInt('last-sync');

    if (lastSync != null && server != null) {
      var newItems = await FeedService(server).countItemsSince(kDebugMode ? 0 : lastSync);
      _log.info("New items from background job: $newItems");

      if (newItems > 0) {
        var locals = AppLocalizationsEn();
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 10,
            // we hardcode that so if the user already has a notification, it is replaced
            channelKey: newItemsChannel,
            actionType: ActionType.Default,
            title: locals.newFeedItemsNotificationTitle(newItems),
          ),
        );
      }
    }
  }

  static Future<void> setupNotifications() async {
    if (!kIsWeb && Platform.isAndroid) {
      var prefs = await SharedPreferences.getInstance();
      var notifications = prefs.getBool('notifications') ?? false;
      var notificationsFrequency = prefs.getInt('notifications-frequency') ?? 1;

      await Workmanager().cancelByUniqueName('check-notifications');
      if (notifications) {
        await Workmanager().registerPeriodicTask(
          'check-notifications',
          'check-notifications',
          frequency: kDebugMode ? Duration(minutes: 1) : Duration(hours: notificationsFrequency),
        );
      }
    }
  }
}

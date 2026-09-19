import 'package:app/home/state/local_preferences.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/notifications/notification_handler.dart';
import 'package:app/settings/views/components/responsive_setting_child.dart';
import 'package:auto_route/annotations.dart';
import 'package:awesome_notifications/awesome_notifications.dart' hide NotificationHandler;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => LocalPreferencesCubit(LocalPreferencesState()),
      child: BlocBuilder<LocalPreferencesCubit, LocalPreferencesState>(
        builder: (context, state) {
          final cubit = context.read<LocalPreferencesCubit>();
          return ResponsiveSettingChild(
            title: locals.notifications,
            child: Column(
              children: [
                SwitchListTile(
                  value: state.notifications,
                  title: Text(locals.notifications),
                  subtitle: Text(locals.notificationsSubtitle),
                  onChanged: (value) {
                    if (value) {
                      AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
                        if (!isAllowed) {
                          // This is just a basic example. For real apps, you must show some
                          // friendly dialog box before call the request method.
                          // This is very important to not harm the user experience
                          AwesomeNotifications().requestPermissionToSendNotifications();
                        }
                      });
                    }
                    cubit.setNotifications(value);
                  },
                ),
                ListTile(
                  enabled: state.notifications,
                  title: Text('${locals.notificationFrequency} (${locals.nHours(state.notificationsFrequency)})'),
                  subtitle: Slider(
                    min: 1,
                    max: 24,
                    divisions: 24,
                    label: locals.nHours(state.notificationsFrequency),
                    value: state.notificationsFrequency.toDouble(),
                    onChanged: state.notifications
                        ? (double value) {
                            cubit.setNotificationsFrequency(value.toInt());
                          }
                        : null,
                  ),
                ),
                if (kDebugMode)
                  ListTile(title: Text('Test notification'), onTap: () => NotificationHandler.checkNewFeedItems()),
                if (kDebugMode)
                  ListTile(title: Text('Test work manager'), onTap: () => NotificationHandler.testWorkmanager()),
              ],
            ),
          );
        },
      ),
    );
  }
}

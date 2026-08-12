import 'package:app/identity/states/identity.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/main.dart';
import 'package:app/router.dart';
import 'package:app/utils/models/breakpoints.dart';
import 'package:app/utils/views/components/auto_leading_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;
    return AutoTabsRouter.tabBar(
      routes: [FeedsSettingsRoute(), LayoutSettingsRoute(), GeneralSettingsRoute(), UserSettingsRoute(), InfoRoute()],
      builder: (context, child, tabController) {
        return Scaffold(
          appBar: AppBar(
            leading: NewskuAutoLeadingButton(),
            title: Text(locals.settings),
            actions: [
              TextButton.icon(
                onPressed: () => getIt.get<IdentityCubit>().logout(),
                label: Text(locals.logout),
                icon: Icon(Icons.logout),
              ),
            ],
            bottom: TabBar(
              controller: tabController,
              tabs: [
                Tab(text: locals.feeds, icon: Icon(Icons.rss_feed)),
                Tab(text: locals.layout, icon: Icon(Icons.grid_view_sharp)),
                Tab(text: locals.general, icon: Icon(Icons.settings)),
                Tab(text: locals.user, icon: Icon(Icons.person)),
                Tab(text: locals.about, icon: Icon(Icons.info_outline)),
              ],
            ),
          ),
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: BreakPoint.tablet.maxWidth),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}

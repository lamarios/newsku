import 'package:app/l10n/app_localizations.dart';
import 'package:app/router.dart';
import 'package:app/stats/states/stats_state.dart';
import 'package:app/utils/models/breakpoints.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/auto_leading_button.dart';
import 'package:app/utils/views/components/conditional_wrap.dart';
import 'package:app/utils/views/components/error_listener.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_loading_indicator/loading_indicator.dart';

@RoutePage()
class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;

    return AutoTabsRouter.tabBar(
      routes: [TagStatsRoute(), FeedStatsRoute()],
      builder: (context, child, tabController) => Scaffold(
        appBar: AppBar(
          leading: NewskuAutoLeadingButton(),
          title: Text(locals.stats),
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(text: locals.tags, icon: Icon(Icons.sell)),
              Tab(text: locals.feeds, icon: Icon(Icons.rss_feed)),
            ],
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: BreakPoint.tablet.maxWidth),
              child: BlocProvider(
                create: (context) => StatsCubit(StatsState()),
                child: ErrorHandler<StatsCubit, StatsState>(
                  child: BlocBuilder<StatsCubit, StatsState>(
                    builder: (context, state) {
                      if (state.loading) {
                        return Center(child: LoadingIndicator());
                      } else {
                        return ConditionalWrap(
                          wrapIf: BreakPoint.get(context) == .mobile,
                          wrapper: (child) => Padding(
                            padding: .symmetric(horizontal: pu2),
                            child: child,
                          ),
                          child: child,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

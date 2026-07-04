import 'package:app/feed/models/feed.dart';
import 'package:app/feed/models/feed_category.dart';
import 'package:app/feed/states/main_feed.dart';
import 'package:app/home/views/components/drawer_feed_category.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class FeedsDrawer extends StatelessWidget {
  static double drawerWidth = 400;

  const FeedsDrawer({super.key});

  Iterable<Feed> catFeeds(FeedCategory cat, List<Feed> feeds) => feeds.where((f) => f.category?.id == cat.id);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final locals = AppLocalizations.of(context)!;

    return BlocBuilder<MainFeedCubit, MainFeedState>(
      builder: (context, state) {
        final categories = List.from(state.categories);

        categories.add(FeedCategory(name: locals.uncategorized, id: null));

        return Container(
          width: drawerWidth - pu2,
          decoration: BoxDecoration(
            borderRadius: .only(topRight: .circular(20), bottomRight: .circular(20)),

            color: colors.surfaceContainer,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(pu4),
              child: Column(
                crossAxisAlignment: .stretch,
                children: [
                  Text(locals.feeds, style: textTheme.titleLarge),
                  Gap(pu4),
                  ...categories
                      .where((cat) => catFeeds(cat, state.feeds).isNotEmpty)
                      .map((cat) => DrawerFeedCategory(category: cat, feeds: catFeeds(cat, state.feeds).toList())),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

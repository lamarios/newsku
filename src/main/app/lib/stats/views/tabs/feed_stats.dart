import 'package:app/feed/views/components/feed_image.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/stats/states/stats_state.dart';
import 'package:app/stats/views/components/no_stats.dart';
import 'package:app/stats/views/components/stat_bar.dart';
import 'package:app/utils/utils.dart';
import 'package:auto_route/annotations.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class FeedStatsTab extends StatelessWidget {
  const FeedStatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;

    final stats = context.read<StatsCubit>().state.stats.feedClicks;

    return Padding(
      padding: .only(top: pu4),
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: pu4,
        children: [
          Text(locals.feedStatsExplanation),
          if (stats.isEmpty) NoStats(),
          if (stats.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: stats.length,
                itemBuilder: (context, index) {
                  var s = stats[index];
                  return StatBar(
                    key: ValueKey(s.feed.id),
                    heading: Row(
                      spacing: pu2,
                      children: [
                        ClipRRect(
                          borderRadius: .circular(30),
                          child: FeedImage(item: s.feed, height: 30, width: 30),
                        ),
                        Expanded(child: Text(s.feed.name ?? '')),
                        Text(s.clicks.toString()),
                      ],
                    ),
                    value: s.clicks,
                    max: stats.first.clicks,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

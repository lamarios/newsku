import 'package:app/feed/models/feed.dart';
import 'package:app/feed/models/feed_category.dart';
import 'package:app/feed/models/feed_item.dart';
import 'package:app/feed/states/main_feed.dart';
import 'package:app/feed/views/components/date_bar.dart';
import 'package:app/feed/views/components/feed_image.dart';
import 'package:app/feed/views/components/search_result.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/layouts/models/layout_block.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';

class FeedUtils {
  static final Logger _log = Logger('FeedUtils');

  static List<Widget> buildSingleFeedSliver({
    required BuildContext context,
    Feed? feed,
    required List<FeedItem> items,
    required EdgeInsets padding,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final cubit = context.read<MainFeedCubit>();

    if (feed == null) {
      return [];
    }

    return [
      SliverPadding(
        padding: padding,
        sliver: SliverAppBar(
          pinned: true,
          backgroundColor: colors.surface,
          surfaceTintColor: colors.surface,
          actions: [IconButton(onPressed: () => cubit.selectFeed(null), icon: Icon(Icons.close))],
          title: Row(
            children: [
              ClipRRect(
                borderRadius: .circular(30),
                child: FeedImage(item: feed, width: 30, height: 30),
              ),
              Gap(pu4),
              Expanded(child: Text(feed.name ?? '', style: textTheme.titleLarge)),
            ],
          ),
        ),
      ),
      SliverPadding(
        padding: padding,
        sliver: SliverList.builder(
          itemCount: items.length,
          itemBuilder: (context, index) => SearchResult(item: items[index], fullDate: true, noDimming: true),
        ),
      ),
    ];
  }

  static List<Widget> buildSlivers({
    required BuildContext context,
    required DateTimeRange<DateTime> timeRange,
    required List<FeedItem> immutableItems,
    required List<LayoutBlock> blocks,
    required List<FeedCategory> categories,
    required int readItems,
    required EdgeInsets padding,
  }) {
    final locals = AppLocalizations.of(context)!;

    List<Widget> slivers = [];
    _log.fine(
      'Building Slivers, TimeRange: $timeRange, Layout blocks: ${blocks.length}, Items: ${immutableItems.length}',
    );

    List<FeedItem> items = List.from(immutableItems);

    // for each block, we try to fit items
    for (final (index, block) in blocks.indexed) {
      if (items.isEmpty) {
        break;
      }

      List<FeedItem> blockItems = [];
      if (index == blocks.length - 1) {
        // if we're in the last block, we take all items
        blockItems = List.from(items);
      } else {
        int blockSize = block.type.fixedItemSize ?? block.settings?.items ?? 0;
        _log.fine('${block.type}: Block Size: $blockSize');
        // we take the items the block is expecting
        var list = items
            .where((i) => block.settings?.categoryId == null || i.feed?.category?.id == block.settings?.categoryId)
            .take(blockSize)
            .toList();

        blockItems.addAll(list);
      }
      _log.fine('Block item: ${blockItems.length}');

      if (blockItems.isNotEmpty) {
        _log.fine('Adding block ${block.type} with ${blockItems.length} items');
        slivers.add(block.type.getSliver(context: context, items: blockItems, block: block, categories: categories));
      }

      // we remove them from the main list
      for (var element in blockItems) {
        items.remove(element);
      }
    }

    for (int i = 0; i < slivers.length; i++) {
      slivers[i] = SliverPadding(
        padding: padding,
        sliver: SliverStickyHeader.builder(
          builder: (context, state) => DateBar(date: timeRange.end, isPinned: state.isPinned, isFirst: i == 0),

          sliver: slivers[i],
        ),
      );
    }

    if (readItems > 0) {
      final colors = Theme.of(context).colorScheme;
      final textTheme = Theme.of(context).textTheme;

      slivers.add(
        SliverPadding(
          padding: .only(top: pu4),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: .center,
              spacing: pu2,
              children: [
                Icon(Icons.task_alt, color: colors.secondary, size: 15),
                Text(locals.readItems(readItems), style: textTheme.bodySmall?.copyWith(color: colors.secondary)),
              ],
            ),
          ),
        ),
      );
    }

    return slivers;
  }
}

import 'package:app/feed/models/feed_category.dart';
import 'package:app/feed/models/feed_item.dart';
import 'package:app/feed/views/components/clickable_feed_item.dart';
import 'package:app/feed/views/components/feed_item_image.dart';
import 'package:app/feed/views/components/info_bar.dart';
import 'package:app/feed/views/components/item_content.dart';
import 'package:app/feed/views/components/item_title.dart';
import 'package:app/feed/views/screens/feed_screen.dart';
import 'package:app/layouts/models/layout_block.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

const double _roundImageSize = 100;

class TopStories extends StatelessWidget {
  final FeedCategory? category;
  final List<FeedItem> items;
  final LayoutBlock block;

  const TopStories({super.key, required this.items, required this.block, this.category});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      clipBehavior: .none,
      // constraints: BoxConstraints(maxHeight: 500),
      decoration: BoxDecoration(color: colors.surfaceContainerHigh, borderRadius: .circular(feedItemBorderRadius)),
      padding: .all(pu4),
      child: Row(
        spacing: pu6,
        crossAxisAlignment: .start,
        children: [
          Align(
            alignment: .topCenter,
            child: RotatedBox(
              quarterTurns: 1,
              child: Container(
                decoration: BoxDecoration(color: colors.tertiary, borderRadius: .circular(50)),
                padding: .symmetric(horizontal: pu4),
                child: Text(
                  category?.name ?? (block.settings ?? block.type.defaultSettings).title ?? '★ Top Stories',
                  maxLines: 1,
                  overflow: .ellipsis,
                  style: textTheme.bodyLarge?.copyWith(fontSize: 20, color: colors.onTertiary),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: .min,
              spacing: pu6,
              children: items
                  .skip(1)
                  .indexed
                  .map(
                    (e) => ClickableFeedItem(
                      item: e.$2,
                      key: Key('top-stories-${e.$1}'),
                      builder: (hovered) => Column(
                        children: [
                          Row(
                            spacing: pu6,
                            children: [
                              FeedItemImage(
                                item: e.$2,
                                width: _roundImageSize,
                                height: _roundImageSize,
                                borderRadius: .circular(_roundImageSize),
                                border: .all(color: colors.tertiary, width: 5),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: .stretch,
                                  children: [
                                    ItemTitle(
                                      item: e.$2,
                                      hovered: hovered,
                                      style: textTheme.headlineMedium?.copyWith(height: 1.4),
                                      maxLines: 2,
                                      overflow: .ellipsis,
                                    ),
                                    InfoBar(item: e.$2),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (e.$1 < items.skip(1).length - 1) ...[
                            Gap(pu6),
                            Align(
                              alignment: .center,
                              child: SizedBox(
                                width: 200,
                                child: Divider(indent: 16, thickness: 3, radius: .circular(20)),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          if (items.isNotEmpty)
            Expanded(
              key: Key('top-stories-headline'),
              child: ClickableFeedItem(
                item: items.first,
                builder: (hovered) => Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .stretch,
                  mainAxisAlignment: .start,
                  spacing: pu,
                  children: [
                    FeedItemImage(item: items.first, height: 200, borderRadius: .circular(feedItemBorderRadius)),
                    ItemTitle(
                      item: items.first,
                      hovered: hovered,
                      style: textTheme.headlineLarge?.copyWith(height: 1.4),
                      maxLines: 3,
                      overflow: .ellipsis,
                    ),
                    ItemContent(item: items.first, maxLines: 2, overflow: .ellipsis),
                    InfoBar(item: items.first),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

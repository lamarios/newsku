import 'package:app/feed/models/feed_category.dart';
import 'package:app/feed/models/feed_item.dart';
import 'package:app/feed/views/components/clickable_feed_item.dart';
import 'package:app/feed/views/components/feed_item_image.dart';
import 'package:app/feed/views/components/info_bar.dart';
import 'package:app/feed/views/components/item_content.dart';
import 'package:app/feed/views/components/item_title.dart';
import 'package:app/feed/views/screens/feed_screen.dart';
import 'package:app/utils/models/breakpoints.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';

class SmallGridItem extends StatelessWidget {
  final FeedCategory? category;
  final FeedItem item;

  const SmallGridItem({super.key, required this.item, this.category});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return ClickableFeedItem(
      item: item,
      builder: (hovered) => Container(
        // constraints: BoxConstraints(maxHeight: 100),
        // margin: .only(top: 16),
        decoration: BoxDecoration(color: colors.surfaceContainerHigh, borderRadius: .circular(feedItemBorderRadius)),
        child: Row(
          crossAxisAlignment: .stretch,
          children: [
            Expanded(
              child: Padding(
                padding: .symmetric(horizontal: pu4, vertical: pu2),
                child: Column(
                  crossAxisAlignment: .stretch,
                  spacing: pu,
                  children: [
                    ItemTitle(
                      item: item,
                      hovered: hovered,
                      style: textTheme.bodyLarge,
                      overflow: .ellipsis,
                      maxLines: 2,
                    ),
                    Align(
                      alignment: .centerLeft,
                      child: ItemContent(item: item, maxLines: 1, overflow: .ellipsis),
                    ),
                    Spacer(),
                    InfoBar(item: item),
                  ],
                ),
              ),
            ),
            Align(
              alignment: .centerLeft,
              child: Container(width: 4, height: 50, decoration: BoxDecoration(color: colors.tertiary)),
            ),
            FeedItemImage(
              item: item,
              borderRadius: .horizontal(right: .circular(feedItemBorderRadius)),
              width: switch (BreakPoint.get(context)) {
                .mobile => 20,
                .tablet => 50,
                _ => 70,
              },
            ),
          ],
        ),
      ),
    );
  }
}

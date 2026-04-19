import 'package:app/feed/models/feed_category.dart';
import 'package:app/feed/models/feed_item.dart';
import 'package:app/feed/views/components/clickable_feed_item.dart';
import 'package:app/feed/views/components/feed_item_image.dart';
import 'package:app/feed/views/components/info_bar.dart';
import 'package:app/feed/views/components/item_content.dart';
import 'package:app/feed/views/components/item_title.dart';
import 'package:app/feed/views/screens/feed_screen.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BigGridItem extends StatelessWidget {
  final FeedCategory? category;
  final FeedItem item;

  const BigGridItem({super.key, required this.item, this.category});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return ClickableFeedItem(
      item: item,
      builder: (hovered) => Container(
        decoration: BoxDecoration(color: colors.surfaceContainerHigh, borderRadius: .circular(feedItemBorderRadius)),
        child: Column(
          spacing: 0,
          crossAxisAlignment: .stretch,
          children: [
            FeedItemImage(
              item: item,
              height: 180,
              borderRadius: BorderRadius.vertical(top: .circular(feedItemBorderRadius)),
            ),
            Align(
              alignment: .centerLeft,
              child: Container(
                width: 100,
                height: 8,
                margin: .only(left: 8),
                decoration: BoxDecoration(color: colors.tertiary),
              ),
            ),
            Gap(pu2),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(pu2),
                child: Column(
                  crossAxisAlignment: .stretch,
                  spacing: pu2,
                  children: [
                    ItemTitle(
                      item: item,
                      hovered: hovered,
                      style: textTheme.headlineSmall,
                      maxLines: 3,
                      overflow: .ellipsis,
                    ),
                    // Expanded(child: Text(item.description ?? item.content ?? '', maxLines: 3,)),
                    Expanded(
                      child: ItemContent(item: item, maxLines: 4, overflow: .ellipsis),
                    ),
                    InfoBar(item: item),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

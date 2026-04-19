import 'package:app/feed/models/feed_category.dart';
import 'package:app/feed/models/feed_item.dart';
import 'package:app/feed/views/components/clickable_feed_item.dart';
import 'package:app/feed/views/components/feed_item_image.dart';
import 'package:app/feed/views/components/info_bar.dart';
import 'package:app/feed/views/components/item_content.dart';
import 'package:app/feed/views/components/item_title.dart';
import 'package:app/utils/models/breakpoints.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SearchResult extends StatelessWidget {
  final FeedCategory? category;
  final FeedItem item;
  final bool fullDate;
  final bool noDimming;

  const SearchResult({super.key, required this.item, this.fullDate = false, this.noDimming = false, this.category});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final breakPoint = BreakPoint.get(context);

    return Padding(
      padding: .symmetric(horizontal: breakPoint == .mobile ? pu2 : pu8, vertical: pu4),
      child: ClickableFeedItem(
        noDimming: noDimming,
        item: item,
        builder: (hovered) => Row(
          crossAxisAlignment: .center,
          children: [
            FeedItemImage(
              item: item,
              width: breakPoint == .mobile ? 75 : 100,
              height: breakPoint == .mobile ? 75 : 100,
              borderRadius: .circular(10),
            ),
            Gap(breakPoint == .mobile ? pu4 : pu8),
            Expanded(
              child: Column(
                crossAxisAlignment: .stretch,
                spacing: pu2,
                children: [
                  ItemTitle(
                    item: item,
                    hovered: hovered,
                    style: breakPoint == .mobile ? textTheme.titleMedium : textTheme.headlineSmall,
                    maxLines: 2,
                    overflow: .ellipsis,
                  ),
                  ItemContent(item: item, maxLines: breakPoint == .mobile ? 1 : 3, overflow: .ellipsis),
                  InfoBar(item: item, fullDate: fullDate),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

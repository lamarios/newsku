import 'package:app/feed/models/feed_category.dart';
import 'package:app/feed/models/feed_item.dart';
import 'package:app/feed/views/components/category_pill.dart';
import 'package:app/feed/views/components/clickable_feed_item.dart';
import 'package:app/feed/views/components/feed_item_image.dart';
import 'package:app/feed/views/components/info_bar.dart';
import 'package:app/feed/views/components/item_content.dart';
import 'package:app/feed/views/components/item_title.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/conditional_wrap.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Headline extends StatelessWidget {
  final FeedCategory? category;
  final FeedItem item;

  const Headline({super.key, required this.item, this.category});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: .symmetric(horizontal: pu),
      child: ClickableFeedItem(
        item: item,
        builder: (hovered) => Column(
          crossAxisAlignment: .stretch,
          children: [
            ConditionalWrap(
              wrapIf: category != null,
              wrapper: (child) => SizedBox(
                height: 350,
                child: Stack(
                  children: [
                    Positioned(top: 0, left: 0, right: 0, bottom: 0, child: child),
                    Positioned(
                      top: pu2,
                      left: pu2,
                      child: CategoryPill(category: category!),
                    ),
                  ],
                ),
              ),
              child: FeedItemImage(item: item, height: 350, borderRadius: .circular(10)),
            ),
            Gap(pu4),
            ItemTitle(item: item, style: textTheme.displaySmall, hovered: hovered),
            Gap(pu2),
            ItemContent(item: item, maxLines: 5, style: textTheme.bodyLarge),
            Gap(pu4),
            InfoBar(item: item),
          ],
        ),
      ),
    );
  }
}

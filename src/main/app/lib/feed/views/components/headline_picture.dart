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

class HeadlinePicture extends StatelessWidget {
  final FeedItem item;

  const HeadlinePicture({super.key, required this.item});

  @override
  Widget build(BuildContext outerContext) {
    return Theme(
      data: ThemeData.dark(useMaterial3: true),
      child: Builder(
        builder: (context) {
          final textTheme = Theme.of(context).textTheme;
          return ClickableFeedItem(
            item: item,
            builder: (hovered) => ClipRRect(
              borderRadius: .circular(10),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: FeedItemImage(
                          item: item,
                          width: BreakPoint.tablet.maxWidth,
                          height: 450,
                          borderRadius: .circular(10),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: .symmetric(vertical: pu4, horizontal: pu6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black.withValues(alpha: 0), Colors.black.withValues(alpha: 0.7)],
                          begin: .topCenter,
                          end: .bottomCenter,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: .end,
                        crossAxisAlignment: .stretch,
                        children: [
                          ItemTitle(item: item, hovered: hovered, style: textTheme.displaySmall),
                          Gap(pu2),
                          ItemContent(item: item, maxLines: 1, overflow: .ellipsis, style: textTheme.bodyLarge),
                          Gap(pu4),
                          InfoBar(item: item),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

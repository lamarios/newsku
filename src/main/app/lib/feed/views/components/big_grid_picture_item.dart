import 'package:app/feed/models/feed_item.dart';
import 'package:app/feed/views/components/clickable_feed_item.dart';
import 'package:app/feed/views/components/feed_item_image.dart';
import 'package:app/feed/views/components/info_bar.dart';
import 'package:app/feed/views/components/item_content.dart';
import 'package:app/feed/views/components/item_title.dart';
import 'package:app/feed/views/screens/feed_screen.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';

class BigGridPictureItem extends StatelessWidget {
  final FeedItem item;

  const BigGridPictureItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(useMaterial3: true),
      child: Builder(
        builder: (context) {
          final textTheme = Theme.of(context).textTheme;
          final colors = Theme.of(context).colorScheme;
          return ClickableFeedItem(
            item: item,
            builder: (hovered) => ClipRRect(
              borderRadius: .circular(10),
              child: Container(
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHigh,
                  borderRadius: .circular(feedItemBorderRadius),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: FeedItemImage(item: item, borderRadius: .circular(10)),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: .symmetric(vertical: pu4, horizontal: pu6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black.withValues(alpha: 0), Colors.black.withValues(alpha: 0.9)],
                            begin: .topCenter,
                            end: .bottomCenter,
                          ),
                        ),
                        child: Column(
                          spacing: pu2,
                          mainAxisSize: .max,
                          mainAxisAlignment: .end,
                          crossAxisAlignment: .stretch,
                          children: [
                            ItemTitle(
                              item: item,
                              hovered: hovered,
                              style: textTheme.headlineSmall,
                              maxLines: 3,
                              overflow: .ellipsis,
                            ),
                            // Expanded(child: Text(item.description ?? item.content ?? '', maxLines: 3,)),
                            ItemContent(item: item, maxLines: 1, overflow: .ellipsis),
                            InfoBar(item: item),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:app/feed/models/feed.dart';
import 'package:app/feed/views/components/feed_image.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';

class DraggedFeed extends StatelessWidget {
  final Feed feed;

  const DraggedFeed({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(color: colors.secondaryContainer, borderRadius: .circular(pu4)),
      padding: .symmetric(horizontal: pu4, vertical: pu2),
      child: Row(
        spacing: pu4,
        children: [
          FeedImage(item: feed, width: 30, height: 30),
          Text(feed.name ?? '', style: textTheme.bodyLarge),
        ],
      ),
    );
  }
}

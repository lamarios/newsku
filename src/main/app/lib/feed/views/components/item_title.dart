import 'package:app/feed/models/feed_item.dart';
import 'package:flutter/material.dart';
import 'package:motor/motor.dart';

class ItemTitle extends StatelessWidget {
  final FeedItem item;
  final bool hovered;
  final int? maxLines;
  final TextStyle? style;
  final TextOverflow? overflow;

  const ItemTitle({super.key, required this.item, this.maxLines, this.style, this.overflow, required this.hovered});

  @override
  Widget build(BuildContext outerContext) {
    return SingleMotionBuilder(
      motion: LinearMotion(Duration(milliseconds: 250)),
      value: hovered ? 1 : 0,
      from: 0,
      builder: (context, value, child) {
        final textTheme = Theme.of(context).textTheme;
        final colors = Theme.of(context).colorScheme;
        var textStyle = style ?? textTheme.bodyMedium;

        return Text(
          key: Key('item-title'),
          item.title ?? '',
          style: (textStyle)?.copyWith(color: Color.lerp(textStyle.color, colors.primary, value)),
          maxLines: maxLines,
          overflow: overflow,
        );
      },
    );
  }
}

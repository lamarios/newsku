import 'dart:math';
import 'dart:ui';

import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/frosted_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motor/motor.dart';

final _df = DateFormat.yMMMd();

class DateBar extends StatelessWidget {
  final DateTime date;
  final bool isPinned;
  final bool isFirst;
  final EdgeInsets padding;

  /// how much of the scroll view's top is covered by the app bar, used to keep the pinned bar clear of the status bar
  final double overlap;

  const DateBar({
    super.key,
    required this.date,
    required this.isPinned,
    required this.isFirst,
    required this.padding,
    this.overlap = 0,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (!isFirst && !isPinned) {
      return SizedBox(height: 64);
    }

    final statusBarGap = max(0.0, MediaQuery.paddingOf(context).top - overlap);

    // the horizontal padding (which includes the drawer width when it's open) only positions the pill, it doesn't
    // size it
    return Padding(
      padding: .only(left: padding.left, right: padding.right),
      child: Center(
        child: SingleMotionBuilder(
          motion: MaterialSpringMotion.expressiveSpatialDefault(),
          from: 0,
          value: isPinned ? 0 : 1,
          // when pinned, push the bar below the status bar, minus whatever part of it the app bar already covers
          builder: (context, value, child) => Padding(
            padding: .only(top: lerpDouble(statusBarGap + pu2, 0, value.clamp(0, 1))!),
            child: FrostedContainer(
              blur: lerpDouble(0, 10, 1 - value)!,
              decoration: BoxDecoration(
                borderRadius: .circular(100),
                color: Color.lerp(
                  colors.tertiaryContainer.withValues(alpha: 0.7),
                  colors.tertiaryContainer.withValues(alpha: 0),
                  value,
                ),
                boxShadow: [],
              ),
              padding: .symmetric(vertical: lerpDouble(pu2, pu * 10, value.clamp(0, 1))!, horizontal: pu4),
              child: Text(
                _df.format(date),
                textAlign: .center,
                style: textTheme.bodyLarge?.copyWith(fontSize: lerpDouble(20, 35, value)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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

  const DateBar({super.key, required this.date, required this.isPinned, required this.isFirst, required this.padding});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (!isFirst && !isPinned) {
      return SizedBox(height: 64);
    }

    final topInset = MediaQuery.paddingOf(context).top;

    return Center(
      child: SingleMotionBuilder(
        motion: MaterialSpringMotion.expressiveSpatialDefault(),
        from: 0,
        value: isPinned ? 0 : 1,
        // when pinned, push the bar below the status bar
        builder: (context, value, child) => Padding(
          padding: .only(top: lerpDouble(topInset, 0, value.clamp(0, 1))!),
          child: FrostedContainer(
            decoration: BoxDecoration(
              borderRadius: .circular(100),
              color: Color.lerp(
                colors.primaryContainer.withValues(alpha: 0.5),
                colors.primaryContainer.withValues(alpha: 0),
                value,
              ),
              boxShadow: [],
            ),
            padding: .symmetric(vertical: lerpDouble(pu2, pu * 10, value.clamp(0, 1))!),
            child: Padding(
              padding: .only(left: padding.left, right: padding.right),
              child: Row(
                mainAxisSize: .min,
                mainAxisAlignment: .center,
                children: [
                  Text(
                    _df.format(date),
                    textAlign: .center,
                    style: textTheme.bodyLarge?.copyWith(fontSize: lerpDouble(20, 35, value)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

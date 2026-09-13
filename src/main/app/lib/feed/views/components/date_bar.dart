import 'dart:ui';

import 'package:app/utils/utils.dart';
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

    return SingleMotionBuilder(
      motion: MaterialSpringMotion.expressiveSpatialDefault(),
      from: 0,
      value: isPinned ? 0 : 1,
      builder: (context, value, child) => Container(
        decoration: BoxDecoration(
          // color: Color.lerp(colors.surface.withValues(alpha: 0.5), colors.surface.withValues(alpha: 0), value),
          color: colors.surface,
        ),
        padding: .symmetric(vertical: lerpDouble(pu2, pu * 10, value.clamp(0, 1))!),
        child: Padding(
          padding: .only(left: padding.left, right: padding.right),
          child: Row(
            mainAxisSize: .max,
            children: [
              Expanded(flex: 1, child: Divider(thickness: lerpDouble(1, 3, value))),
              Expanded(
                flex: 3,
                child: Text(
                  _df.format(date),
                  textAlign: .center,
                  style: textTheme.bodyLarge?.copyWith(fontSize: lerpDouble(13, 35, value)),
                ),
              ),
              Expanded(flex: 1, child: Divider(thickness: lerpDouble(1, 3, value))),
            ],
          ),
        ),
      ),
    );
  }
}

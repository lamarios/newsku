import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:motor/motor.dart';
import 'package:app/utils/motion.dart';

class StatBar extends StatelessWidget {
  final Widget heading;
  final int value;
  final int max;

  const StatBar({super.key, required this.heading, required this.value, required this.max});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: .symmetric(vertical: pu2),
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: pu2,
        children: [
          heading,
          Container(
            height: 10,
            decoration: BoxDecoration(color: colors.primaryContainer, borderRadius: .circular(10)),
            child: SingleMotionBuilder(
              value: value / max,
              from: 0,
              builder: (context, value, child) => FractionallySizedBox(
                heightFactor: 1,
                widthFactor: value.clamp(0, 1),
                alignment: .centerLeft,
                child: child,
              ),
              motion: motionOrNone(context, MaterialSpringMotion.expressiveSpatialSlow()),
              child: Container(
                decoration: BoxDecoration(color: colors.primary, borderRadius: .circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

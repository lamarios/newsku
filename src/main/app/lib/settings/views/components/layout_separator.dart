import 'dart:math';
import 'dart:ui';

import 'package:app/l10n/app_localizations.dart';
import 'package:app/layouts/models/layout_block_types.dart';
import 'package:app/settings/states/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motor/motor.dart';
import 'package:app/utils/motion.dart';

class LayoutSeparator extends StatelessWidget {
  final int index;

  final bool dragging;

  const LayoutSeparator({super.key, required this.index, required this.dragging});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final cubit = context.read<LayoutCubit>();
    final locals = AppLocalizations.of(context)!;
    return DragTarget<LayoutBlockTypes>(
      onAcceptWithDetails: (details) => cubit.acceptDrag(index, details),
      builder: (BuildContext context, List<LayoutBlockTypes?> candidateData, List<dynamic> rejectedData) {
        return SingleMotionBuilder(
          value: dragging ? 1 : 0,
          from: 0,
          motion: motionOrNone(context, MaterialSpringMotion.expressiveSpatialSlow()),
          builder: (context, value, child) => Container(
            margin: .symmetric(horizontal: 56, vertical: max(0, lerpDouble(0, 32, value)!)),
            decoration: BoxDecoration(
              borderRadius: .circular(5),
              border: Border.all(color: Color.lerp(Colors.transparent, colors.primaryContainer, value)!, width: 1),
              color: candidateData.isNotEmpty ? colors.primaryContainer.withValues(alpha: 0.2) : Colors.transparent,
            ),
            height: max(0, lerpDouble(16, 100, value)!),
            child: child,
          ),
          child: AnimatedSwitcher(
            duration: durationOrZero(context, Duration(milliseconds: 250)),
            child: dragging ? Text(locals.dropBlockHere, style: TextStyle(color: colors.primary)) : SizedBox.shrink(),
          ),
        );
      },
    );
  }
}

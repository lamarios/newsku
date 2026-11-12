import 'dart:ui';

import 'package:app/l10n/app_localizations.dart';
import 'package:app/utils/utils.dart';
import 'package:material_ui/material_ui.dart';
import 'package:motor/motor.dart';
import 'package:app/utils/motion.dart';

class Done extends StatelessWidget {
  const Done({super.key});

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return SingleMotionBuilder(
      motion: motionOrNone(context, MaterialSpringMotion.expressiveSpatialSlow()),
      from: 0,
      value: 1,
      builder: (context, value, child) => Opacity(
        opacity: value.clamp(0, 1),
        child: Transform.scale(scale: lerpDouble(0.9, 1, value), child: child),
      ),
      child: Padding(
        padding: EdgeInsets.all(pu6),
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          spacing: pu8,
          children: [
            Text(locals.setupComplete, style: textTheme.displaySmall),
            Icon(Icons.check, size: 100, color: localPreferences.appColor),
          ],
        ),
      ),
    );
  }
}

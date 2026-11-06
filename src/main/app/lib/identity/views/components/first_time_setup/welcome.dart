import 'dart:ui';

import 'package:app/l10n/app_localizations.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:motor/motor.dart';
import 'package:app/utils/motion.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.all(pu6),
      child: SingleMotionBuilder(
        // motion: Motion.linear(Duration(milliseconds: 250)),
        motion: motionOrNone(context, MaterialSpringMotion.expressiveSpatialSlow()),
        from: 0,
        value: 1,
        builder: (context, value, child) => Opacity(
          opacity: value.clamp(0, 1),
          child: Transform.scale(scale: lerpDouble(0.9, 1, value), child: child),
        ),
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          spacing: pu8,
          children: [
            AppLogo(size: 100),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 350),
              child: Text(locals.welcomeText, style: textTheme.bodyLarge, textAlign: .center),
            ),
          ],
        ),
      ),
    );
  }
}

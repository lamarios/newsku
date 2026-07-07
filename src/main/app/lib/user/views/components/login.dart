import 'dart:ui';

import 'package:app/identity/states/identity.dart';
import 'package:app/user/views/components/fancy_side.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/app_logo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motor/motor.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    var announcement = context.read<IdentityCubit>().state.config?.announcement ?? '';
    return Column(
      children: [
        if (announcement.isNotEmpty) ...[
          SingleMotionBuilder(
            motion: MaterialSpringMotion.expressiveSpatialDefault(),
            value: 1,
            from: 0,
            builder: (context, value, child) => Opacity(
              opacity: value.clamp(0, 1),
              child: Transform.translate(offset: Offset(0, lerpDouble(0, 50, 1 - value)!), child: child),
            ),
            child: Container(
              key: Key('announcement'),
              margin: .symmetric(horizontal: 64),
              decoration: BoxDecoration(
                color: colors.tertiaryContainer,
                borderRadius: .only(topLeft: .circular(32), topRight: .circular(32)),
              ),
              padding: .symmetric(horizontal: pu * 9, vertical: pu4),
              child: Row(
                crossAxisAlignment: .center,
                spacing: pu6,
                children: [
                  Icon(Icons.info_outline),
                  Expanded(child: Text(announcement)),
                ],
              ),
            ),
          ),
        ],
        Container(
          decoration: BoxDecoration(color: colors.surfaceContainerHigh, borderRadius: .circular(30)),
          child: Column(
            crossAxisAlignment: .center,
            children: [
              ClipPath(
                clipper: FancyHorizontalSide(),
                child: Container(
                  height: 175,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: localPreferences.appColor,
                    borderRadius: .only(topLeft: .circular(30), topRight: .circular(30)),
                  ),
                  child: Align(
                    alignment: .center,
                    child: AppLogo(size: 70, color: colors.onSurface),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(pu6),
                child: Center(child: AutoRouter()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

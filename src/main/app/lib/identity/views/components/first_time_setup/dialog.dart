import 'dart:ui';

import 'package:app/identity/states/identity.dart';
import 'package:app/identity/views/components/first_time_setup/done.dart';
import 'package:app/identity/views/components/first_time_setup/llm_preference.dart';
import 'package:app/identity/views/components/first_time_setup/welcome.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/settings/views/tabs/feeds.dart';
import 'package:app/settings/views/tabs/layout.dart';
import 'package:app/user/services/user_service.dart';
import 'package:app/utils/models/breakpoints.dart';
import 'package:app/utils/states/simple_cubit.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/simple_cubit_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motor/motor.dart';

class FirstTimeSetupDialog extends StatefulWidget {
  const FirstTimeSetupDialog({super.key});

  @override
  State<FirstTimeSetupDialog> createState() => _FirstTimeSetupDialogState();
}

class _FirstTimeSetupDialogState extends State<FirstTimeSetupDialog> {
  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final maxPages = 5;

    return SimpleCubitView<int>(
      initialValue: 0,
      builder: (context, page) => Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: BreakPoint.tablet.maxWidth, maxHeight: 1000),
          child: Dialog(
            child: Column(
              mainAxisSize: .min,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: pu3, right: pu6, left: pu6, bottom: pu2),
                  child: Align(
                    alignment: .centerLeft,
                    child: switch (page) {
                      1 => Text(locals.feeds, style: textTheme.titleLarge),
                      2 => Text(locals.articlePreference, style: textTheme.titleLarge),
                      3 => Text(locals.layout, style: textTheme.titleLarge),
                      _ => SizedBox.shrink(),
                    },
                  ),
                ),
                [
                  Welcome(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: pu4),
                      child: FeedsSettingsTab(fromFirstTimeSetup: true),
                    ),
                  ),
                  LlmPreference(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: pu6),
                      child: LayoutSettingsTab(fadeColor: colors.surfaceContainerHigh, fromFirstTimeWizard: true),
                    ),
                  ),
                  Done(),
                ][page],

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: pu8, vertical: pu2),
                  child: Row(
                    children: [
                      TextButton(
                        key: Key('back'),
                        onPressed: page == 0 ? null : () => context.read<SimpleCubit<int>>().setValue(page - 1),
                        child: Text(locals.back),
                      ),
                      Expanded(
                        child: _Pager(page: page, maxPages: maxPages),
                      ),
                      if (page < maxPages - 1)
                        TextButton(
                          key: Key('next'),
                          onPressed: () => context.read<SimpleCubit<int>>().setValue(page + 1),
                          child: Text(locals.next),
                        )
                      else
                        TextButton(
                          key: Key('done'),
                          onPressed: () {
                            final user = context.read<IdentityCubit>().state.currentUser;
                            if (user != null) {
                              UserService(serverUrl!).updateUser(user.copyWith(firstTimeSetupDone: true));
                            }
                            Navigator.of(context).pop();
                            // save the user
                          },
                          child: Text(locals.done),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Pager extends StatelessWidget {
  final int page;
  final int maxPages;

  const _Pager({required this.page, required this.maxPages});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    List<Widget> widgets = [];

    for (int i = 0; i < maxPages; i++) {
      widgets.add(
        SingleMotionBuilder(
          value: i == page ? 1 : 0,
          from: 0,
          motion: MaterialSpringMotion.expressiveSpatialDefault(),
          builder: (context, value, child) {
            return Transform.scale(
              scale: lerpDouble(1, 1.5, value),
              child: Container(
                key: ValueKey(i),
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.lerp(colors.primary.withValues(alpha: 0), colors.primary, value.clamp(0, 1)),
                  border: Border.all(color: colors.primary, width: 2),
                ),
              ),
            );
          },
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(pu2),
      child: Row(mainAxisAlignment: .center, spacing: pu4, children: widgets),
    );
  }
}

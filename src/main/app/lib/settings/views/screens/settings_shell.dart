import 'package:app/identity/states/identity.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/main.dart';
import 'package:app/router.dart';
import 'package:app/settings/views/components/settings_empty_details.dart';
import 'package:app/settings/views/components/settings_master_list.dart';
import 'package:app/utils/models/breakpoints.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/auto_leading_button.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsShellScreen extends StatelessWidget {
  const SettingsShellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;
    return AutoRouter(
      builder: (context, child) {
        final isWide = MediaQuery.sizeOf(context).width >= 840;
        if (!isWide) return child; // narrow: nested stack IS the UI — push/pop, back button, all normal

        final router = context.router; // the nested StackRouter for this shell
        final onListRoute = router.current.name == SettingsListRoute.name;

        return Scaffold(
          appBar: AppBar(
            leading: NewskuAutoLeadingButton(),
            title: Text(locals.settings),
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              TextButton.icon(
                onPressed: () => getIt.get<IdentityCubit>().logout(),
                label: Text(locals.logout),
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          body: Row(
            children: [
              SizedBox(
                width: 320,
                child: SettingsMasterList(
                  // highlight the active detail route when wide
                  selectedRouteName: router.current.name,
                  onTap: (route) => router.replace(route), // swap, don't stack
                ),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                child: onListRoute
                    ? const SettingsEmptyDetails() // "select a setting" placeholder
                    : Align(
                        alignment: .topLeft,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: BreakPoint.tablet.maxWidth),
                          child: Padding(
                            padding: .symmetric(horizontal: pu4),
                            child: child,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

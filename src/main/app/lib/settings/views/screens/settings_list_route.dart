import 'package:app/identity/states/identity.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/main.dart';
import 'package:app/settings/views/components/settings_master_list.dart';
import 'package:app/utils/views/components/auto_leading_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsListScreen extends StatelessWidget {
  const SettingsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;

    final router = context.router; // the nested StackRouter for this shell
    return Scaffold(
      appBar: AppBar(
        leading: NewskuAutoLeadingButton(),
        title: Text(locals.settings),
        actions: [
          TextButton.icon(
            onPressed: () => getIt.get<IdentityCubit>().logout(),
            label: Text(locals.logout),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SettingsMasterList(onTap: (route) => router.push(route), selectedRouteName: router.current.name),
    );
  }
}

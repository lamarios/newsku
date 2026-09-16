import 'package:app/l10n/app_localizations.dart';
import 'package:app/settings/states/user_settings.dart';
import 'package:app/settings/views/components/responsive_setting_child.dart';
import 'package:app/user/models/email_digest_frequency.dart';
import 'package:app/utils/utils.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

@RoutePage()
class EmailDigestTab extends StatelessWidget {
  const EmailDigestTab({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locals = AppLocalizations.of(context)!;
    return ResponsiveSettingChild(
      title: locals.emailDigestTitle,
      child: BlocProvider(
        create: (context) => UserSettingsCubit(
          UserSettingsState(
            email: identityCubit.currentUser?.email ?? '',
            digest: identityCubit.currentUser?.emailDigest ?? [],
          ),
        ),
        child: BlocBuilder<UserSettingsCubit, UserSettingsState>(
          builder: (context, state) {
            final cubit = context.read<UserSettingsCubit>();
            final serverConfig = config;
            return Padding(
              padding: .symmetric(horizontal: pu2),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: .stretch,
                  children: [
                    Text(locals.emailDigestTitle, style: textTheme.titleMedium),
                    Text(locals.emailDigestExplanation),
                    Gap(pu4),
                    SegmentedButton<EmailDigestFrequency>(
                      multiSelectionEnabled: true,
                      emptySelectionAllowed: true,
                      onSelectionChanged: (values) =>
                          cubit.setDigestPreference(values.whereType<EmailDigestFrequency>().toList()),
                      segments: EmailDigestFrequency.values
                          .map(
                            (e) => ButtonSegment<EmailDigestFrequency>(
                              value: e,
                              enabled: serverConfig?.canResetPassword ?? false,
                              label: Text(locals.emailDigest(e.name)),
                              icon: Icon(Icons.close),
                            ),
                          )
                          .toList(),
                      selected: state.digest.toSet(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

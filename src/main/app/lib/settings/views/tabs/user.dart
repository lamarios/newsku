import 'package:app/l10n/app_localizations.dart';
import 'package:app/settings/states/user_settings.dart';
import 'package:app/settings/views/components/responsive_setting_child.dart';
import 'package:app/utils/utils.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

@RoutePage()
class UserSettingsTab extends StatelessWidget {
  const UserSettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locals = AppLocalizations.of(context)!;
    return ResponsiveSettingChild(
      title: locals.emailAndPassword,
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
            return Padding(
              padding: .symmetric(horizontal: pu2),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: .stretch,
                  children: [
                    Text(locals.changeEmail, style: textTheme.titleMedium),
                    Gap(pu4),
                    Text(locals.newEmail),
                    TextField(
                      key: Key('email'),
                      controller: cubit.email,
                      decoration: InputDecoration(error: state.validEmail ? null : Text(locals.invalidEmail)),
                    ),
                    Gap(pu2),
                    Align(
                      alignment: .centerRight,
                      child: FilledButton.tonalIcon(
                        onPressed: state.loading || !state.validEmail
                            ? null
                            : () async {
                                await cubit.updateEmail();
                                if (context.mounted) {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(SnackBar(content: Text(locals.emailUpdated)));
                                }
                              },
                        label: Text(locals.update),
                        icon: Icon(Icons.save),
                      ),
                    ),
                    Gap(pu8),
                    Text(locals.changePassword, style: textTheme.titleMedium),
                    Gap(pu4),
                    Text(locals.newPassword),
                    TextField(key: Key('new-password'), controller: cubit.password, obscureText: true),
                    Gap(pu2),
                    Text(locals.confirmPassword),
                    TextField(
                      key: Key('repeat-password'),
                      controller: cubit.repeatPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        error: (state.password != state.repeatPassword) ? Text(locals.passwordsNotMatch) : null,
                      ),
                    ),
                    Gap(pu2),
                    Align(
                      alignment: .centerRight,
                      child: FilledButton.tonalIcon(
                        key: Key('password-update-button'),
                        onPressed: state.loading || state.password != state.repeatPassword || state.password.isEmpty
                            ? null
                            : () async {
                                await cubit.resetPassword();
                                if (context.mounted) {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(SnackBar(content: Text(locals.passwordUpdated)));
                                }
                              },
                        label: Text(locals.update),
                        icon: Icon(Icons.save),
                      ),
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

import 'package:app/l10n/app_localizations.dart';
import 'package:app/settings/states/user_settings.dart';
import 'package:app/settings/views/components/responsive_setting_child.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/error_listener.dart';
import 'package:auto_route/annotations.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

@RoutePage()
class UserSettingsTab extends StatelessWidget {
  const UserSettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locals = AppLocalizations.of(context)!;
    final oidcConfig = identityCubit.state.config?.oidcConfig;
    return ResponsiveSettingChild(
      title: locals.emailAndPassword,
      child: BlocProvider(
        create: (context) => UserSettingsCubit(
          UserSettingsState(
            email: identityCubit.currentUser?.email ?? '',
            digest: identityCubit.currentUser?.emailDigest ?? [],
            ssoLinked: identityCubit.currentUser?.oidcSub != null,
          ),
        ),
        child: ErrorHandler<UserSettingsCubit, UserSettingsState>(
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
                                  final updated = await cubit.updateEmail();
                                  if (updated && context.mounted) {
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
                                  final updated = await cubit.resetPassword();
                                  if (updated && context.mounted) {
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(SnackBar(content: Text(locals.passwordUpdated)));
                                  }
                                },
                          label: Text(locals.update),
                          icon: Icon(Icons.save),
                        ),
                      ),
                      if (oidcConfig != null) ...[
                        Gap(pu8),
                        Text(locals.singleSignOn(oidcConfig.name), style: textTheme.titleMedium),
                        Gap(pu4),
                        Text(state.ssoLinked ? locals.ssoLinked : locals.ssoNotLinked),
                        Gap(pu2),
                        Align(
                          alignment: .centerRight,
                          child: state.ssoLinked
                              ? OutlinedButton.icon(
                                  key: Key('sso-unlink-button'),
                                  onPressed: state.loading
                                      ? null
                                      : () async {
                                          final confirmed = await showDialog<bool>(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text(locals.unlinkSsoTitle),
                                              content: Text(locals.unlinkSsoWarning),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.of(context).pop(false),
                                                  child: Text(locals.cancel),
                                                ),
                                                TextButton(
                                                  key: Key('sso-unlink-confirm'),
                                                  onPressed: () => Navigator.of(context).pop(true),
                                                  child: Text(locals.unlink),
                                                ),
                                              ],
                                            ),
                                          );
                                          if (confirmed == true) {
                                            await cubit.unlinkSso();
                                          }
                                        },
                                  label: Text(locals.unlink),
                                  icon: Icon(Icons.link_off),
                                )
                              : FilledButton.tonalIcon(
                                  key: Key('sso-link-button'),
                                  onPressed: state.loading ? null : cubit.linkSso,
                                  label: Text(locals.linkSsoAccount),
                                  icon: Icon(Icons.link),
                                ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

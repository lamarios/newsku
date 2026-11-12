import 'package:app/l10n/app_localizations.dart';
import 'package:app/router.dart';
import 'package:app/user/states/signup.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/error_listener.dart';
import 'package:auto_route/auto_route.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

@RoutePage()
class SignupFormScreen extends StatelessWidget {
  const SignupFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final locals = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => SignupCubit(SignupState()),
      child: BlocBuilder<SignupCubit, SignupState>(
        builder: (context, state) {
          final cubit = context.read<SignupCubit>();
          return ErrorHandler<SignupCubit, SignupState>(
            child: Padding(
              padding: .only(right: pu6),
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Align(alignment: .centerLeft, child: Text(locals.username)),
                  TextField(
                    key: Key('username-field'),
                    enabled: !state.loading,
                    onChanged: (value) => cubit.setUsername(value),
                    autofillHints: [AutofillHints.newUsername],
                    autocorrect: false,
                  ),
                  Gap(pu4),
                  Align(alignment: .centerLeft, child: Text(locals.email)),
                  TextField(
                    key: Key('email-field'),
                    enabled: !state.loading,
                    onChanged: (value) => cubit.setEmail(value),
                    autofillHints: [AutofillHints.email],
                    autocorrect: false,
                  ),
                  if ((state.email ?? '').trim().isNotEmpty && !RegExp(emailRegex).hasMatch(state.email ?? '')) ...[
                    Gap(pu),
                    Text(locals.invalidEmail, style: textTheme.bodyMedium?.copyWith(color: colors.error)),
                    Gap(pu4),
                  ],
                  Gap(pu4),
                  Align(alignment: .centerLeft, child: Text(locals.password)),
                  TextField(
                    key: Key('password-field'),
                    enabled: !state.loading,
                    obscureText: true,
                    onChanged: (value) => cubit.setPassword(value),
                    autofillHints: [AutofillHints.newPassword],
                    autocorrect: false,
                  ),
                  Gap(pu4),
                  Align(alignment: .centerLeft, child: Text(locals.repeatPassword)),
                  TextField(
                    key: Key('repeat-password-field'),
                    enabled: !state.loading,
                    obscureText: true,
                    onChanged: (value) => cubit.setRepeatPassword(value),
                    autocorrect: false,
                  ),
                  Gap(pu4),
                  if (state.password != state.repeatPassword) ...[
                    Gap(pu),
                    Text(locals.passwordsNotMatch, style: textTheme.bodyMedium?.copyWith(color: colors.error)),
                    Gap(pu4),
                  ],
                  Row(
                    children: [
                      TextButton(
                        onPressed: state.loading ? null : () => AutoRouter.of(context).replace(LoginFormRoute()),
                        child: Text(locals.login),
                      ),
                      Spacer(),
                      FilledButton.tonalIcon(
                        key: Key('signup-button'),
                        onPressed: state.loading || state.invalidForm
                            ? null
                            : () async {
                                await cubit.signup();
                                if (context.mounted) {
                                  AutoRouter.of(context).replace(LoginFormRoute());
                                }
                              },
                        label: Text(locals.signUp),
                        icon: Icon(Icons.login),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

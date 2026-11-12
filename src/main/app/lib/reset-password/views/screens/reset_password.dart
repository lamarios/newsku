import 'package:app/identity/states/identity.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/main.dart';
import 'package:app/reset-password/services/reset_password_service.dart';
import 'package:app/reset-password/states/reset_password.dart';
import 'package:app/router.dart';
import 'package:app/utils/dialog.dart';
import 'package:app/utils/models/breakpoints.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/error_dialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

@RoutePage()
class ResetPasswordScreen extends StatelessWidget {
  final String? token;

  const ResetPasswordScreen({super.key, @queryParam this.token});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final locals = AppLocalizations.of(context)!;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bool error = false;
      if (token == null || JwtDecoder.isExpired(token!)) {
        error = true;
      }

      if (error) {
        okCancelDialog(
          context,
          title: locals.invalidLink,
          content: Text(locals.invalidLink),
          onOk: () => AutoRouter.of(context).replaceAll([LandingRoute()]),
          showCancel: false,
        );
      }

      var claims = JwtDecoder.decode(token!);
      print('claims: $claims');
      getIt.get<IdentityCubit>().setUrl(claims['server-url']);
    });

    return BlocProvider(
      create: (context) => ResetPasswordCubit(ResetPasswordState()),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: BreakPoint.tablet.maxWidth),
              child: Column(
                crossAxisAlignment: .stretch,
                mainAxisAlignment: .center,
                spacing: pu3,
                children: [
                  Text(locals.resetPassword, style: textTheme.titleLarge),
                  BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                    builder: (context, state) {
                      final cubit = context.read<ResetPasswordCubit>();
                      final serverUrl = context.select((IdentityCubit c) => c.state.serverUrl);
                      return Container(
                        decoration: BoxDecoration(color: colors.surfaceContainerHigh, borderRadius: .circular(10)),
                        padding: .all(pu5),
                        child: Column(
                          crossAxisAlignment: .stretch,
                          children: [
                            Text(locals.newPassword),
                            TextField(controller: cubit.password, obscureText: true),
                            Gap(pu4),
                            Text(locals.resetPassword),
                            TextField(
                              controller: cubit.repeatPassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                error: (state.password != state.repeatPassword) ? Text(locals.passwordsNotMatch) : null,
                              ),
                            ),
                            Gap(pu4),
                            Align(
                              alignment: .centerRight,
                              child: FilledButton.tonalIcon(
                                onPressed: state.validPassword
                                    ? () async {
                                        if (serverUrl != null && token != null) {
                                          try {
                                            await ResetPasswordService(
                                              serverUrl,
                                            ).setPassword(password: state.password, token: token!);
                                          } catch (e, s) {
                                            // e.g. a link that was already used
                                            if (context.mounted) {
                                              ErrorDialog.show(context, error: e, trace: s);
                                            }
                                            return;
                                          }

                                          if (context.mounted) {
                                            okCancelDialog(
                                              context,
                                              title: locals.passwordReset,
                                              content: Text(locals.passwordResetExplanation),
                                              onOk: () => AutoRouter.of(context).replaceAll([LandingRoute()]),
                                              showCancel: false,
                                            );
                                          }
                                        }
                                      }
                                    : null,
                                label: Text(locals.save),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

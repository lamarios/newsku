import 'package:app/l10n/app_localizations.dart';
import 'package:app/reset-password/services/reset_password_service.dart';
import 'package:app/router.dart';
import 'package:app/user/states/signup.dart';
import 'package:app/utils/dialog.dart';
import 'package:app/utils/utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:material_ui/material_ui.dart';
import 'package:gap/gap.dart';

@RoutePage()
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Align(alignment: .centerLeft, child: Text(locals.email)),
          TextFormField(
            key: Key('email'),
            autocorrect: false,
            controller: controller,
            validator: (value) {
              if ((value ?? '').trim().isNotEmpty && !RegExp(emailRegex).hasMatch(value!)) {
                return locals.invalidEmail;
              }
              return null;
            },
          ),
          Gap(pu2),
          Align(
            alignment: .centerRight,
            child: FilledButton.tonal(
              key: Key('submit'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await ResetPasswordService(serverUrl!).submitRequest(email: controller.value.text);
                  if (context.mounted) {
                    okCancelDialog(
                      context,
                      title: locals.submitted,
                      content: Text(locals.passwordResetRequestSubmitted),
                      showCancel: false,
                      onOk: () {
                        AutoRouter.of(context).replace(LoginFormRoute());
                      },
                    );
                  }
                }
              },
              child: Text(locals.submit),
            ),
          ),
        ],
      ),
    );
  }
}

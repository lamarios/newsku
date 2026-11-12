import 'package:app/identity/states/identity.dart';
import 'package:app/identity/views/components/first_time_setup/dialog.dart';
import 'package:app/utils/states/simple_cubit.dart';
import 'package:app/utils/views/components/simple_cubit_view.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstTimeSetupTrigger extends StatelessWidget {
  final Widget child;

  const FirstTimeSetupTrigger({super.key, required this.child});

  Future<void> showSetupDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FirstTimeSetupDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleCubitView<bool>(
      builder: (context, dialogShown) {
        final firstTimeSetupDone = context.select(
          (IdentityCubit c) => c.state.currentUser?.firstTimeSetupDone ?? false,
        );

        if (!dialogShown && !firstTimeSetupDone) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.read<SimpleCubit<bool>>().setValue(true);
            showSetupDialog(context);
          });
        }

        return child;
      },
      initialValue: false,
    );
  }
}

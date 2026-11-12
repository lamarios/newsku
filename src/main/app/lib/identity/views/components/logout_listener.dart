import 'package:app/identity/states/identity.dart';
import 'package:app/main.dart';
import 'package:app/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutListener extends StatelessWidget {
  final Widget child;

  const LogoutListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!getIt.get<IdentityCubit>().isLoggedIn) {
        AutoRouter.of(context).replaceAll([LandingRoute()]);
      }
    });

    return BlocListener<IdentityCubit, IdentityState>(
      listener: (context, state) {
        if (!state.isLoggedIn) {
          AutoRouter.of(context).replaceAll([LandingRoute()]);
        }
      },
      child: child,
    );
  }
}

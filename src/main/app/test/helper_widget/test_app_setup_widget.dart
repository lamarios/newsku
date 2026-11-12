import 'package:app/home/state/local_preferences.dart';
import 'package:app/identity/states/identity.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/main.dart';
import 'package:app/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestSetup extends StatelessWidget {
  final Widget child;

  const TestSetup({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt.get<LocalPreferencesCubit>()),
        BlocProvider(create: (context) => getIt.get<IdentityCubit>()),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: StackRouterScope(
          controller: AppRouter(loggedInOnStart: false),
          stateHash: 0,
          child: Scaffold(body: child),
        ),
      ),
    );
  }
}

class DeepLinkTestSetup extends StatelessWidget {
  final PageRouteInfo route;

  const DeepLinkTestSetup({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt.get<LocalPreferencesCubit>()),
        BlocProvider(create: (context) => getIt.get<IdentityCubit>()),
      ],
      child: MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: AppRouter(loggedInOnStart: false).config(deepLinkBuilder: (deepLink) => DeepLink.single(route)),
      ),
    );
  }
}

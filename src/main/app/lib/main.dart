import 'package:app/home/state/local_preferences.dart';
import 'package:app/identity/states/identity.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/router.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/main_color_provider.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

late final appRouter;

final getIt = GetIt.instance;

Future<void> main() async {
  Logger.root.level = kDebugMode ? Level.ALL : Level.INFO;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  WidgetsFlutterBinding.ensureInitialized();
  addAppLicense();
  var identityCubit = IdentityCubit(IdentityState());
  getIt.registerSingleton<IdentityCubit>(identityCubit);
  await identityCubit.init();

  getIt.registerSingleton<LocalPreferencesCubit>(LocalPreferencesCubit(LocalPreferencesState()));

  appRouter = AppRouter(loggedInOnStart: identityCubit.isLoggedIn);

  runApp(BetterFeedback(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final inputTheme = InputDecorationThemeData(border: OutlineInputBorder());

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt.get<LocalPreferencesCubit>()),
        BlocProvider(create: (context) => getIt.get<IdentityCubit>()),
      ],
      child: BlocBuilder<LocalPreferencesCubit, LocalPreferencesState>(
        builder: (context, preferences) {
          return MainColorProvider(
            builder: (context, appColor) {
              return MaterialApp.router(
                title: 'Newsku',
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                routerConfig: appRouter.config(),

                darkTheme: ThemeData(
                  colorScheme: .fromSeed(
                    seedColor: appColor,
                    brightness: Brightness.dark,
                    surface: preferences.blackBackground ? Colors.black : Color.fromARGB(255, 17, 18, 20),
                    surfaceContainerHigh: Color.fromARGB(255, 35, 36, 40),
                    onSurface: Colors.white,
                  ),
                  inputDecorationTheme: inputTheme,
                ),
                themeMode: preferences.theme,
                theme: ThemeData(
                  // This is the theme of your application.
                  //
                  // TRY THIS: Try running your application with "flutter run". You'll see
                  // the application has a purple toolbar. Then, without quitting the app,
                  // try changing the seedColor in the colorScheme below to Colors.green
                  // and then invoke "hot reload" (save your changes or press the "hot
                  // reload" button in a Flutter-supported IDE, or press "r" if you used
                  // the command line to start the app).
                  //
                  // Notice that the counter didn't reset back to zero; the application
                  // state is not lost during the reload. To reset the state, use hot
                  // restart instead.
                  //
                  // This works for code too, not just values: Most code changes can be
                  // tested with just a hot reload.
                  inputDecorationTheme: inputTheme,
                  colorScheme: .fromSeed(
                    seedColor: appColor,
                    surface: Colors.white,
                    surfaceContainerHigh: Color.fromARGB(255, 233, 234, 237),
                    onSurface: Colors.black,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

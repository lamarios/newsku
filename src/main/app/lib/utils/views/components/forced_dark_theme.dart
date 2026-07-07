import 'package:app/home/state/local_preferences.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForcedDarkThemeBuilder extends StatelessWidget {
  final Function(BuildContext context) builder;

  const ForcedDarkThemeBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final blackBackground = context.select((LocalPreferencesCubit c) => c.state.blackBackground);
    return Theme(
      data: ThemeData(
        colorScheme: .fromSeed(
          seedColor: localPreferences.appColor,
          brightness: Brightness.dark,
          surface: blackBackground ? Colors.black : Color.fromARGB(255, 17, 18, 20),
          surfaceContainerHigh: Color.fromARGB(255, 35, 36, 40),
          onSurface: Colors.white,
        ),
      ),
      child: Builder(builder: (innerContext) => builder(innerContext)),
    );
  }
}

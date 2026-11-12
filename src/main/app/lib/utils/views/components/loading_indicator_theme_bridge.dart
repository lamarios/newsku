import 'package:material_loading_indicator/loading_indicator_theme.dart';
import 'package:material_ui/material_ui.dart';

/// `material_loading_indicator` still reads colors from the deprecated `package:flutter/material.dart` [Theme], which
/// the app no longer provides since it moved to `package:material_ui`. Without this it falls back to the default purple
/// color scheme. This passes the current `material_ui` color scheme to it through its own [LoadingIndicatorTheme].
///
/// Use it right below any widget that sets a [Theme].
class LoadingIndicatorThemeBridge extends StatelessWidget {
  final Widget child;

  const LoadingIndicatorThemeBridge({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return LoadingIndicatorTheme(
      data: LoadingIndicatorThemeData(
        activeIndicatorColor: colorScheme.primary,
        containerColor: colorScheme.primaryContainer,
      ),
      child: child,
    );
  }
}

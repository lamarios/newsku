import 'package:app/utils/models/breakpoints.dart';
import 'package:app/utils/views/components/conditional_wrap.dart';
import 'package:flutter/material.dart';

class ResponsiveSettingChild extends StatelessWidget {
  final String title;
  final Widget child;
  final bool disableScaffold;
  const ResponsiveSettingChild({super.key, required this.child, required this.title, this.disableScaffold = false});

  @override
  Widget build(BuildContext context) {
    final isMobile = BreakPoint.get(context) == .mobile;
    return ConditionalWrap(
      wrapIf: !disableScaffold && isMobile,
      wrapper: (child) => Scaffold(
        appBar: AppBar(title: Text(title), scrolledUnderElevation: 0, backgroundColor: Colors.transparent),
        body: child,
      ),
      child: child,
    );
  }
}

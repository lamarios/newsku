import 'package:material_ui/material_ui.dart';

class ConditionalWrap extends StatelessWidget {
  final bool wrapIf;
  final Widget Function(Widget child)? wrapElse;
  final Widget Function(Widget child) wrapper;
  final Widget child;

  const ConditionalWrap({super.key, required this.wrapIf, required this.wrapper, required this.child, this.wrapElse});

  @override
  Widget build(BuildContext context) {
    if (!wrapIf) {
      return wrapElse?.call(child) ?? child;
    } else {
      return wrapper(child);
    }
  }
}

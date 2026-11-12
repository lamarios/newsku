import 'package:material_ui/material_ui.dart';

enum BreakPoint {
  mobile(maxWidth: 500),
  tablet(maxWidth: 800),
  desktop(maxWidth: 1280),
  bigDesktop(maxWidth: 999999);

  final double maxWidth;

  const BreakPoint({required this.maxWidth});

  static BreakPoint get(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var bps = List<BreakPoint>.from(BreakPoint.values);
    bps.sort((a, b) => a.maxWidth.compareTo(b.maxWidth));

    return bps.where((element) => width <= element.maxWidth).first;
  }
}

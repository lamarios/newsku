import 'package:app/utils/motion.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motor/motor.dart';

void main() {
  Widget motionApp({required bool disableAnimations, required double value}) {
    return MediaQuery(
      data: MediaQueryData(disableAnimations: disableAnimations),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Builder(
          builder: (context) => SingleMotionBuilder(
            motion: motionOrNone(context, MaterialSpringMotion.expressiveSpatialSlow()),
            from: 0,
            value: value,
            builder: (context, value, child) => Text(value.toStringAsFixed(2)),
          ),
        ),
      ),
    );
  }

  testWidgets('motions reach their target immediately when animations are disabled', (tester) async {
    await tester.pumpWidget(motionApp(disableAnimations: true, value: 1));
    await tester.pump(const Duration(milliseconds: 16));
    expect(find.text('1.00'), findsOneWidget);

    await tester.pumpWidget(motionApp(disableAnimations: true, value: 0));
    await tester.pump(const Duration(milliseconds: 16));
    expect(find.text('0.00'), findsOneWidget);
  });

  testWidgets('motions still animate when animations are enabled', (tester) async {
    await tester.pumpWidget(motionApp(disableAnimations: false, value: 1));
    await tester.pump(const Duration(milliseconds: 16));
    expect(find.text('1.00'), findsNothing);

    await tester.pumpAndSettle();
    expect(find.text('1.00'), findsOneWidget);
  });
}

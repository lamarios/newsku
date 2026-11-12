import 'package:app/utils/utils.dart';
import 'package:material_ui/material_ui.dart';
import 'package:motor/motor.dart';

/// Whether animations should be skipped, either because the user enabled the in-app setting or because the OS asks
/// for reduced motion (e.g. "Remove animations" on Android, prefers-reduced-motion on the web).
///
/// The app root overrides [MediaQuery.disableAnimations] with the in-app setting, so this covers both.
bool reduceMotion(BuildContext context) => MediaQuery.disableAnimationsOf(context);

/// Same as [reduceMotion] for places without a [BuildContext].
bool get reduceMotionEnabled =>
    localPreferences.reduceMotion || WidgetsBinding.instance.platformDispatcher.accessibilityFeatures.disableAnimations;

// Motion.none() holds the current value and never reaches the target, and a zero duration CurvedMotion divides by
// zero on its first frame, so the shortest non-zero duration is used to snap to the target on the next frame.
const _instantMotion = Motion.linear(Duration(microseconds: 1));

/// Returns [motion], or a motion that jumps straight to its target when animations are disabled.
Motion motionOrNone(BuildContext context, Motion motion) => reduceMotion(context) ? _instantMotion : motion;

/// Returns [duration], or [Duration.zero] when animations are disabled.
Duration durationOrZero(BuildContext context, Duration duration) => reduceMotion(context) ? Duration.zero : duration;

/// Scrolls [controller] to [offset], animating only when animations are enabled.
Future<void> scrollTo(
  ScrollController controller,
  double offset, {
  required Duration duration,
  required Curve curve,
}) async {
  if (reduceMotionEnabled) {
    controller.jumpTo(offset);
  } else {
    await controller.animateTo(offset, duration: duration, curve: curve);
  }
}

class _NoTransitionsBuilder extends PageTransitionsBuilder {
  const _NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) => child;
}

/// Page transitions that show the new page immediately, for every platform.
final noPageTransitionsTheme = PageTransitionsTheme(
  builders: {for (final platform in TargetPlatform.values) platform: const _NoTransitionsBuilder()},
);

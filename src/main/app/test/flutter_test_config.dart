import 'dart:async';

import 'package:app/utils/utils.dart' as utils;

/// Pins the current time for every test so date-dependent widgets (e.g. the feed date bar) render the same golden
/// images no matter which day the tests run on.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  utils.now = () => DateTime(2026, 11, 6, 12);
  await testMain();
}

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterUtils on WidgetTester {
  Future<void> pumpFor({
    Duration duration = const Duration(seconds: 10),
  }) async {
    bool timerDone = false;
    final timer = Timer(duration, () => timerDone = true);
    while (!timerDone) {
      await pump();
      await Future.delayed(const Duration(milliseconds: 100));
    }
    timer.cancel();
  }

  Future<void> pumpUntilFound(
    Finder finder, {
    Duration timeout = const Duration(seconds: 10),
  }) async {
    bool timerDone = false;
    bool found;
    final timer = Timer(timeout, () => timerDone = true);
    while (!timerDone) {
      found = any(finder);
      if (found) {
        timerDone = false;
        break;
      }
      await pump();
    }

    timer.cancel();
    expect(
      finder,
      findsAtLeastNWidgets(1),
      reason: 'Failed to find: $finder',
    );
  }
}

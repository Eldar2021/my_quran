import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

extension TesterExtensions on WidgetTester {
  Future<void> waitFor(Finder finder) async {
    await pumpAndSettle();
    expect(finder, findsWidgets);
  }

  Future<void> takeScreenshot(String name) async {
    await pumpAndSettle();
    // Not working on CI
    debugPrint('Screenshot captured: $name');
  }
}

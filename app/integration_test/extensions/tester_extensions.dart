import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

extension TesterExtensions on WidgetTester {
  Future<void> waitFor(Finder finder) async {
    await pumpAndSettle();
    expect(finder, findsWidgets);
  }

  Future<void> takeScreenshot(String name) async {
    await pumpAndSettle();

    final binding = IntegrationTestWidgetsFlutterBinding.instance;
    await binding.convertFlutterSurfaceToImage();
    await pumpAndSettle();

    try {
      await binding.takeScreenshot(name);
      debugPrint('Screenshot captured: $name');
    } on Object catch (e) {
      debugPrint('Failed to capture screenshot $name: $e');
    }
  }
}

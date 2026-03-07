import 'package:flutter_test/flutter_test.dart';

extension TesterExtensions on WidgetTester {
  Future<void> waitFor(Finder finder) async {
    await pumpAndSettle();
    expect(finder, findsWidgets);
  }

  Future<void> takeScreenshot(String name) async {
    await pumpAndSettle();

    // In order for takeScreenshot to work on Android/iOS natively,
    // we need to call the binding's takeScreenshot method.
    final binding = IntegrationTestWidgetsFlutterBinding.instance;
    await binding.convertFlutterSurfaceToImage();
    await pumpAndSettle();

    try {
      await binding.takeScreenshot(name);
      debugPrint('Screenshot captured: $name');
    } catch (e) {
      debugPrint('Failed to capture screenshot $name: $e');
    }
  }
}

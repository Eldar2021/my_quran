import 'package:flutter_test/flutter_test.dart';

extension TesterExtensions on WidgetTester {
  Future<void> waitFor(Finder finder) async {
    await pumpAndSettle();
    expect(finder, findsWidgets);
  }

  Future<void> takeScreenshot(String name) async {
    // Screenshot functionality can be bound here using integration_test binding if needed.
    // For now we just pump to ensure everything is rendered.
    await pumpAndSettle();
    // In actual implementation, `IntegrationTestWidgetsFlutterBinding.instance.takeScreenshot(name);` could be used.
  }
}

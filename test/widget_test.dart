import 'package:flutter_test/flutter_test.dart';

import 'helpers/helpers.dart';

void main() {
  testWidgets('Punmp app', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpApp();
    await tester.pumpAndSettle();
    expect(find.text('Language'), findsOneWidget);

    // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);

    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}

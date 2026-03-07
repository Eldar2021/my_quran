import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

Future<void> goBottomHome(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key(MqKeys.home)));
  await tester.pumpAndSettle();
}

Future<void> goBottomMore(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key(MqKeys.morePageKey)));
  await tester.pumpAndSettle();
}

Future<void> goBottomQuranRead(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key(MqKeys.quaranRead)));
  await tester.pumpAndSettle();
}

Future<void> goBottomQuranAudio(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key(MqKeys.quranAudio)));
  await tester.pumpAndSettle();
}

Future<void> goBottomSettings(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key(MqKeys.settings)));
  await tester.pumpAndSettle();
}

Future<void> backPage(WidgetTester tester) async {
  final backButton = find.byTooltip('Back');
  if (backButton.evaluate().isNotEmpty) {
    await tester.tap(backButton.first);
  } else {
    // Fallback if there is a generic back button type
    await tester.tap(find.byType(BackButton));
  }
  await tester.pumpAndSettle();
}

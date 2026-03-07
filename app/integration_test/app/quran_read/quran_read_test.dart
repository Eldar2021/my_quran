import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import '../../extensions/extensions.dart';
import '../../helpers/helpers.dart';
import '../navigation.dart';

Future<void> checkQuranReadJuzs(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.quaranReadInitPage)));
  await tester.tap(find.byKey(const Key(MqKeys.quaranReadJuzs)));
  await tester.waitFor(find.byKey(Key(MqKeys.quranReadJus(2))));
  await tester.takeScreenshot(Screenshots.readQuranJuzs);
}

Future<void> checkQuranReadSurahs(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.quaranReadInitPage)));
  await tester.tap(find.byKey(const Key(MqKeys.quaranReadSurahs)));
  await tester.waitFor(find.byKey(Key(MqKeys.quranReadSurah(2))));
  await tester.takeScreenshot(Screenshots.readQuranSurahs);
}

Future<void> readBaqara(WidgetTester tester) async {
  await tester.waitFor(find.byKey(Key(MqKeys.quranReadSurah(1))));
  await tester.tap(find.byKey(Key(MqKeys.quranReadSurah(1))));
  await tester.waitFor(find.byKey(const Key(MqKeys.quranReadView)));
  await tester.takeScreenshot(Screenshots.readQuranBaqarah);
}

Future<void> checkQuranSettings(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.quranReadSettings)));
  await tester.tap(find.byKey(const Key(MqKeys.quranReadSettings)));
  await tester.waitFor(find.byKey(const Key(MqKeys.quranBookSettingsSheet)));
  await tester.takeScreenshot(Screenshots.readQuranSettings);
  await tester.dragUntilVisible(
    find.byKey(const Key(MqKeys.quranReadSettingsBack)),
    find.byKey(const Key(MqKeys.quranBookSettingsSheet)),
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key(MqKeys.quranReadSettingsBack)));
  await tester.pumpAndSettle();
}

Future<void> backQuranReadInitPageFromQuranReadView(
  WidgetTester tester,
) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.quranReadView)));
  await backPage(tester);
  await tester.waitFor(find.byKey(const Key(MqKeys.quaranReadInitPage)));
}

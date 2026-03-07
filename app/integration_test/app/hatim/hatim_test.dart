import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import '../../extensions/extensions.dart';
import '../../helpers/helpers.dart';

Future<void> checkHatimJuzs(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.hatimPage)));
  await tester.waitFor(find.byKey(const Key(MqKeys.hatimJuzsList)));
  await tester.takeScreenshot(Screenshots.hatimJuzs);
}

Future<void> tapHatimJuz(WidgetTester tester) async {
  await tester.tap(find.byKey(Key(MqKeys.hatimJuzIndex(1))));
  await tester.waitFor(find.byKey(const Key(MqKeys.hatimSelectPage)));
}

Future<void> checkHatimSelectPage(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.hatimSelectPage)));
  await tester.takeScreenshot(Screenshots.hatimPages);
}

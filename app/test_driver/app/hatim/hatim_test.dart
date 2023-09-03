import 'package:flutter_driver/flutter_driver.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import '../../extensions/extensions.dart';

Future<void> checkHatimJuzs(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.hatimPage));
  await driver.waitFor(find.byValueKey(MqKeys.hatimJuzsList));
  await driver.takeScreenshot(Screenshots.hatimJuzs);
}

Future<void> tapHatimJuz(FlutterDriver driver) async {
  await driver.tap(find.byValueKey(MqKeys.hatimJuzIndex(2)));
  await driver.waitFor(find.byValueKey(MqKeys.hatimSelectPage));
}

Future<void> checkHatimSelectPage(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.hatimSelectPage));
  await driver.takeScreenshot(Screenshots.hatimPages);
}

Future<void> backHatimJuzs(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey(MqKeys.hatimSelectPage),
    find.byValueKey(MqKeys.hatimJuzsList),
    dyScroll: -50,
  );
  await driver.tap(find.byValueKey(MqKeys.hatimSelectPageCancel));
  await driver.waitFor(find.byValueKey(MqKeys.hatimJuzsList));
}

import 'package:flutter_driver/flutter_driver.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import '../../extensions/extensions.dart';

Future<void> checkHatimJuzs(FlutterDriver driver) async {
  print('checkHatimJuzs init');
  await driver.waitFor(find.byValueKey(MqKeys.hatimPage));
  print('checkHatimJuzs waitFor hatimPage');
  await driver.waitFor(find.byValueKey(MqKeys.hatimJuzsList));
  print('checkHatimJuzs waitFor hatimJuzsList');
  await driver.takeScreenshot(Screenshots.hatimJuzs);
  print('checkHatimJuzs takeScreenshot');
}

Future<void> tapHatimJuz(FlutterDriver driver) async {
  print('tapHatimJuz init');
  await driver.tap(find.byValueKey(MqKeys.hatimJuzIndex(1)));
  print('tapHatimJuz tap');
  // await driver.waitFor(find.byValueKey(MqKeys.hatimSelectPage));
  print('tapHatimJuz waitFor fake');
}

Future<void> checkHatimSelectPage(FlutterDriver driver) async {
  print('checkHatimSelectPage init');
  await driver.waitFor(find.byValueKey(MqKeys.hatimSelectPage));
  print('checkHatimSelectPage tap');
  await driver.takeScreenshot(Screenshots.hatimPages);
  print('checkHatimSelectPage takeScreenshot');
}

// Future<void> backHatimJuzs(FlutterDriver driver) async {
//   await driver.scrollUntilVisible(
//     find.byValueKey(MqKeys.hatimSelectPageScroll),
//     find.byValueKey(MqKeys.hatimSelectPageCancel),
//     dyScroll: -50,
//   );
//   await driver.tap(find.byValueKey(MqKeys.hatimSelectPageCancel));
//   await driver.waitFor(find.byValueKey(MqKeys.hatimJuzsList));
// }

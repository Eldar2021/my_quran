import 'package:flutter_driver/flutter_driver.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import '../../extensions/extensions.dart';

Future<void> checkQuranReadJuzs(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.quaranReadInitPage));
  await driver.tap(find.byValueKey(MqKeys.quaranReadJuzs));
  await driver.waitFor(find.byValueKey(MqKeys.quranReadJus(2)));
  await driver.takeScreenshot(Screenshots.readQuranJuzs);
}

Future<void> checkQuranReadSurahs(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.quaranReadInitPage));
  await driver.tap(find.byValueKey(MqKeys.quaranReadSurahs));
  await driver.waitFor(find.byValueKey(MqKeys.quranReadSurah(2)));
  await driver.takeScreenshot(Screenshots.readQuranSurahs);
}

Future<void> readBaqara(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.quranReadSurah(1)));
  await driver.tap(find.byValueKey(MqKeys.quranReadSurah(1)));
  await driver.waitFor(find.byValueKey(MqKeys.quranReadView));
  await driver.takeScreenshot(Screenshots.readQuranBaqarah);
}

Future<void> checkQuranSettings(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.quranReadSettings));
  await driver.tap(find.byValueKey(MqKeys.quranReadSettings));
  await driver.takeScreenshot(Screenshots.readQuranSettings);
  await driver.tap(find.byValueKey(MqKeys.quranReadSettingsBack));
}

Future<void> backQuranReadInitPageFromQuranReadView(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.quranReadView));
  await driver.tap(find.pageBack());
  await driver.waitFor(find.byValueKey(MqKeys.quaranReadInitPage));
}

import 'package:flutter_driver/flutter_driver.dart';

import '../../extensions/extensions.dart';

Future<void> checkQuranReadJuzs(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('quran-view'));
  await driver.waitFor(find.byValueKey('juz-items'));
  await driver.takeScreenshot(Screenshots.readQuranJuzs);
}

Future<void> checkQuranReadSurahs(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('quran-view'));
  await driver.waitFor(find.byValueKey('surah-items'));
  await driver.takeScreenshot(Screenshots.readQuranJuzs);
}

Future<void> goQuranReadJuzs(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('quran-view'));
  await driver.tap(find.byValueKey('juz-items'));
}

Future<void> goQuranReadSurahs(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('quran-view'));
  await driver.tap(find.byValueKey('surah-items'));
}

import 'package:flutter_driver/flutter_driver.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import '../../extensions/extensions.dart';
import '../navigation.dart';

Future<void> checkSettingsView(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.settingsView));
  await driver.takeScreenshot(Screenshots.settingsInit);
}

Future<void> checkSettingsGender(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.settingsGender));
  await driver.tap(find.byValueKey(MqKeys.settingsGender));
  await driver.waitFor(find.byValueKey(MqKeys.settingsGenderPage));
  await driver.tap(find.byValueKey(MqKeys.settingsGenderMale));
  await driver.takeScreenshot(Screenshots.settingsGenderMale);
  await driver.tap(find.byValueKey(MqKeys.settingsGenderFemale));
  await driver.takeScreenshot(Screenshots.settingsGenderFemale);
  await backPage(driver);
}

Future<void> checkSettingsLanguage(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.settingsLanguage));
  await driver.tap(find.byValueKey(MqKeys.settingsLanguage));
  await driver.waitFor(find.byValueKey(MqKeys.settingsLanguagePage));
  await driver.tap(find.byValueKey(MqKeys.languageCode('ky')));
  await driver.takeScreenshot(Screenshots.settingsLanguagePageKy);
  await driver.tap(find.byValueKey(MqKeys.languageCode('en')));
  await driver.takeScreenshot(Screenshots.settingsLanguagePageEn);
  await backPage(driver);
}

Future<void> checkSettingsAboutUs(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.settingsAboutUs));
  await driver.tap(find.byValueKey(MqKeys.settingsAboutUs));
  await driver.waitFor(find.byValueKey(MqKeys.settingsAboutUsPage));
  await driver.takeScreenshot(Screenshots.settingsAboutUsPage);
  await backPage(driver);
}

Future<void> checkSettingsContactUs(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.settingsContactUs));
  await driver.tap(find.byValueKey(MqKeys.settingsContactUs));
  await driver.waitFor(find.byValueKey(MqKeys.settingsContactUsPage));
  await driver.takeScreenshot(Screenshots.settingsContactUsPage);
  await backPage(driver);
}

Future<void> checkSettingsDevelopers(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.settingsDevelopers));
  await driver.tap(find.byValueKey(MqKeys.settingsDevelopers));
  await driver.waitFor(find.byValueKey(MqKeys.settingsDevelopersPage));
  await driver.takeScreenshot(Screenshots.settingsDevelopersPage);
  await backPage(driver);
}

Future<void> checkSettingsTheme(FlutterDriver driver) async {}

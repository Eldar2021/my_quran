import 'package:flutter_driver/flutter_driver.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import '../../extensions/extensions.dart';
import '../navigation.dart';

Future<void> goSettings(FlutterDriver driver) async {
  await driver.tap(find.byValueKey(MqKeys.settings));
}

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

Future<void> checkSettingsTheme(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.settingsTheme));
  await driver.tap(find.byValueKey(MqKeys.settingsTheme));
  await driver.waitFor(find.byValueKey(MqKeys.settingsThemePage));
  await driver.tap(find.byValueKey(MqKeys.settingsThemeColorName('Green')));
  await driver.takeScreenshot(Screenshots.settingsThemePageLightGreen);
  await driver.tap(find.byValueKey(MqKeys.settingsThemeColorName('Blue')));
  await driver.takeScreenshot(Screenshots.settingsThemePageLightBlue);
  await driver.tap(find.byValueKey(MqKeys.settingsThemeColorName('Red')));
  await driver.takeScreenshot(Screenshots.settingsThemePageLightRed);
  await driver.tap(find.byValueKey(MqKeys.settingsThemeDark));
  await driver.takeScreenshot(Screenshots.settingsThemePageDarkRed);
  await driver.tap(find.byValueKey(MqKeys.settingsThemeLight));
  await backPage(driver);
}

Future<void> checkLogout(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.settingsView));
  await driver.tap(find.byValueKey(MqKeys.logoutButton));
  await driver.waitFor(find.byValueKey(MqKeys.confirmLogoutButton));
  await driver.tap(find.byValueKey(MqKeys.confirmLogoutButtonYes));
  await driver.waitFor(find.byValueKey(MqKeys.loginSelectLeng));
  await driver.takeScreenshot(Screenshots.logout);
}

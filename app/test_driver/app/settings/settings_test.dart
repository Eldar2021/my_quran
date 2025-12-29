import 'package:flutter_driver/flutter_driver.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import '../../extensions/extensions.dart';
import '../navigation.dart';

Future<void> goSettings(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await goBottomMore(driver);
    await driver.waitFor(find.byValueKey(MqKeys.settingsGenderLang));
  });
}

Future<void> checkSettingsView(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(MqKeys.settingsGenderLang));
    await driver.takeScreenshot(Screenshots.settingsInit);
  });
}

Future<void> checkSettingsGender(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(MqKeys.settingsGenderLang));
    await driver.tap(find.byValueKey(MqKeys.settingsGenderLang));
    await driver.waitFor(find.byValueKey(MqKeys.settingsGenderMale));
    await driver.tap(find.byValueKey(MqKeys.settingsGenderMale));
    await driver.takeScreenshot(Screenshots.settingsGenderMale);
    await driver.tap(find.byValueKey(MqKeys.settingsGenderFemale));
    await driver.takeScreenshot(Screenshots.settingsGenderFemale);
    await backPage(driver);
  });
}

Future<void> checkSettingsAboutUs(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(MqKeys.settingsAboutUs));
    await driver.tap(find.byValueKey(MqKeys.settingsAboutUs));
    await driver.waitFor(find.byValueKey(MqKeys.settingsAboutUsPage));
    await driver.takeScreenshot(Screenshots.settingsAboutUsPage);
    await backPage(driver);
  });
}

Future<void> checkSettingsContactUs(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(MqKeys.settingsContactUs));
    await driver.tap(find.byValueKey(MqKeys.settingsContactUs));
    await driver.waitFor(find.byValueKey(MqKeys.settingsContactUsPage));
    await driver.takeScreenshot(Screenshots.settingsContactUsPage);
    await backPage(driver);
  });
}

Future<void> checkSettingsDevelopers(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(MqKeys.settingsDevelopers));
    await driver.tap(find.byValueKey(MqKeys.settingsDevelopers));
    await driver.waitFor(find.byValueKey(MqKeys.settingsDevelopersPage));
    await driver.takeScreenshot(Screenshots.settingsDevelopersPage);
    await backPage(driver);
  });
}

Future<void> checkSettingsTheme(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(MqKeys.settingsGenderLang));
    await driver.tap(find.byValueKey(MqKeys.settingsGenderLang));
    await driver.waitFor(find.byValueKey(MqKeys.settingsThemeColorName('Orange')));
    await driver.tap(find.byValueKey(MqKeys.settingsThemeColorName('Orange')));
    await driver.takeScreenshot(Screenshots.settingsThemePageLightGreen);
    await driver.tap(find.byValueKey(MqKeys.settingsThemeColorName('Blue')));
    await driver.takeScreenshot(Screenshots.settingsThemePageLightBlue);
    await backPage(driver);
  });
}

Future<void> checkLogout(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(MqKeys.settingsGenderLang));
    await driver.tap(find.byValueKey(MqKeys.logoutButton));
    await driver.takeScreenshot(Screenshots.logout);
  });
}

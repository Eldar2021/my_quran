import 'package:flutter_driver/flutter_driver.dart';

import '../../extensions/extensions.dart';

Future<void> selectLang(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('login-select-lang-text'));
  await driver.takeScreenshot(Screenshots.loginLangPage);
  await driver.tap(find.byValueKey('login-button'));
}

Future<void> selectGender(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('login-select-gender'));
  await driver.takeScreenshot(Screenshots.loginGenderPage);
  await driver.tap(find.byValueKey('login-button'));
}

import 'package:flutter_driver/flutter_driver.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import '../../extensions/extensions.dart';

Future<void> selectLang(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.loginSelectLeng));
  await driver.tap(find.byValueKey(MqKeys.languageCode('ky')));
  await driver.takeScreenshot(Screenshots.loginLangKyPage);
  await driver.tap(find.byValueKey(MqKeys.languageCode('en')));
  await driver.takeScreenshot(Screenshots.loginLangEnPage);
}

Future<void> selectGender(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.loginSelectGender));
  await driver.tap(find.byValueKey(MqKeys.genderName('female')));
  await driver.takeScreenshot(Screenshots.loginGenderFemalePage);
  await driver.tap(find.byValueKey(MqKeys.genderName('male')));
  await driver.takeScreenshot(Screenshots.loginGenderMalePage);
}

Future<void> loginWithGoogleApple(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.signInView));
  await driver.tap(find.byValueKey(MqKeys.loginTypeName('google')));
  await driver.takeScreenshot(Screenshots.loginApplePage);
  await Future<void>.delayed(const Duration(seconds: 1));
}

Future<void> loginNext(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.loginNext));
  await driver.tap(find.byValueKey(MqKeys.loginNext));
}

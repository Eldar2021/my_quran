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

/*
These functions are placeholders for future implementation.

Future<void> registerWithEmail(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.registerView));
  await driver.tap(find.byValueKey(MqKeys.registerTypeName('email')));
  await driver.takeScreenshot(Screenshots.registerEmailPage);
  await Future<void>.delayed(const Duration(seconds: 1));
}

Future<void> loginWithEmail(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.signInView));
  await driver.tap(find.byValueKey(MqKeys.loginTypeName('email')));
  await driver.takeScreenshot(Screenshots.loginEmailPage);
  await Future<void>.delayed(const Duration(seconds: 1));
}
*/

Future<void> loginWithGoogle(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.signInView));
  await driver.tap(find.byValueKey(MqKeys.loginTypeName('google')));
  await driver.takeScreenshot(Screenshots.loginGooglePage);
  await Future<void>.delayed(const Duration(seconds: 1));
}

Future<void> loginNext(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.loginNext));
  await driver.tap(find.byValueKey(MqKeys.loginNext));
}

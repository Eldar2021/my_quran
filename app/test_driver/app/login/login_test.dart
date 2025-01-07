import 'package:flutter_driver/flutter_driver.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import '../../extensions/extensions.dart';

Future<void> selectLang(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(MqKeys.loginInitial));
    // await driver.tap(find.byValueKey(MqKeys.language));
    // await driver.tap(find.byValueKey(MqKeys.languageCode('ky')));
    // await driver.takeScreenshot(Screenshots.loginLangKyPage);
    // await driver.tap(find.byValueKey(MqKeys.language));
    // await driver.tap(find.byValueKey(MqKeys.languageCode('en')));
    await driver.takeScreenshot(Screenshots.loginLangEnPage);
  });
}

Future<void> selectGender(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(MqKeys.loginInitial));
    await driver.tap(find.byValueKey(MqKeys.genderName('female')));
    await driver.takeScreenshot(Screenshots.loginGenderFemalePage);
    await driver.tap(find.byValueKey(MqKeys.genderName('male')));
    await driver.takeScreenshot(Screenshots.loginGenderMalePage);
  });
}

Future<void> sendOtp(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(MqKeys.signInView));
    await driver.tap(find.byValueKey(MqKeys.emailTextField));
    await driver.enterText('test@example.com');
    await driver.tap(find.byValueKey(MqKeys.sendOtp));
    await driver.takeScreenshot(Screenshots.sendOtp);
  });
}

Future<void> verifyOtp(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(MqKeys.verifyOtpView));
    await driver.tap(find.byValueKey(MqKeys.otpTextField));
    await driver.enterText('1234');
    await driver.tap(find.byValueKey(MqKeys.loginTypeName('email')));
    await driver.takeScreenshot(Screenshots.loginEmail);
    await Future<void>.delayed(const Duration(seconds: 1));
  });
}

Future<void> loginWithGoogle(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(MqKeys.signInView));
    await driver.takeScreenshot(Screenshots.loginGooglePage);
    await driver.tap(find.byValueKey(MqKeys.loginTypeName('google')));
    await Future<void>.delayed(const Duration(seconds: 1));
  });
}

Future<void> loginNext(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(MqKeys.loginNext));
    await driver.tap(find.byValueKey(MqKeys.loginNext));
  });
}

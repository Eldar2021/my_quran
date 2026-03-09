import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import '../../extensions/extensions.dart';
import '../../helpers/helpers.dart';

Future<void> selectLang(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.loginInitial)));
  await tester.takeScreenshot(Screenshots.loginLangEnPage);
}

Future<void> selectGender(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.loginInitial)));
  await tester.tap(find.byKey(Key(MqKeys.genderName('female'))));
  await tester.pumpAndSettle();
  await tester.takeScreenshot(Screenshots.loginGenderFemalePage);
  await tester.tap(find.byKey(Key(MqKeys.genderName('male'))));
  await tester.pumpAndSettle();
  await tester.takeScreenshot(Screenshots.loginGenderMalePage);
}

Future<void> sendOtp(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.signInView)));
  await tester.enterText(find.byKey(const Key(MqKeys.emailTextField)), 'test@example.com');
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key(MqKeys.sendOtp)));
  await tester.pump();
  await tester.takeScreenshot(Screenshots.sendOtp);
}

Future<void> verifyOtp(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.verifyOtpView)));
  await tester.enterText(find.byKey(const Key(MqKeys.otpTextField)), '1234');
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(Key(MqKeys.loginTypeName('email'))));
  await tester.takeScreenshot(Screenshots.loginEmail);
  await addDelay(1000);
}

Future<void> loginWithGoogle(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.signInView)));
  await tester.takeScreenshot(Screenshots.loginGooglePage);
  await tester.tap(find.byKey(Key(MqKeys.loginTypeName('google'))));
  await addDelay(1000);
}

Future<void> loginNext(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.loginNext)));
  await tester.tap(find.byKey(const Key(MqKeys.loginNext)));
  await tester.pumpAndSettle();
}

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'app/app.dart';

void main() async {
  late FlutterDriver driver;

  group('Hatim App Integration Test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();

      await driver.waitUntilFirstFrameRasterized();
    });
  });

  group('login', () {
    test('check-login-select-language', () async {
      await selectLang(driver);
    });

    test('go-login-gender', () async {
      await loginNext(driver);
    });

    test('check-login-select-gender', () async {
      await selectGender(driver);
    });

    test('create-account', () async {
      await loginNext(driver);
    });
  });

  tearDownAll(() async {
    await driver.close();
  });
}

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

  group('Login', () {
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

  group('Home', () {
    test('check-home-view', () async {
      await homeInit(driver);
    });

    test('go-hatim', () async {
      await goToHatimPageFromHome(driver);
    });
  });

  group('Hatim', () {
    test('check-hatim-juzs-page', () async {
      await checkHatimJuzs(driver);
    });

    test('go-hatim-select-pages-view', () async {
      await tapHatimJuz(driver);
    });

    test('check-hatim-select-pages-view', () async {
      await checkHatimSelectPage(driver);
    });

    test('back-hatim-select-juzs-view', () async {
      await backHatimJuzs(driver);
    });

    test('back-home-view', () async {
      await backPage(driver);
    });
  });

  tearDownAll(() async {
    await driver.close();
  });
}

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'app/app.dart';
import 'helpers/helpers.dart';

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

    test('sign-in-with-google-account', () async {
      await loginWithGoogleApple(driver);
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

  group('Quran-Read', () {
    test('go-quran-read', () async {
      await goBottomQuranRead(driver);
    });

    test('check-quran-read-juzs', () async {
      await checkQuranReadJuzs(driver);
    });

    test('check-quran-read-surahs', () async {
      await checkQuranReadSurahs(driver);
    });

    test('read-baqara-read-view', () async {
      await readBaqara(driver);
    });

    test('check-quran-settings', () async {
      await checkQuranSettings(driver);
    });

    test('back-quran-read', () async {
      await backQuranReadInitPageFromQuranReadView(driver);
    });
  });

  group('Quran-Audio', () {
    test('go-quran-audio', () async {
      await goBottomQuranAudio(driver);
    });

    test('check-quran-audio-view', () async {
      await checkQuranAudioView(driver);
    });

    test('play-fatiha-and-baqara', () async {
      await playFatihaAndBaqara(driver);
    });
  });

  group('Settings', () {
    test('go-settings', () async {
      await goBottomSettings(driver);
    });

    test('check-settings-view', () async {
      await checkSettingsView(driver);
    });

    test('check-settings-gender', () async {
      await checkSettingsGender(driver);
    });

    test('check-settings-language', () async {
      await checkSettingsLanguage(driver);
    });

    test('check-settings-about-us', () async {
      await checkSettingsAboutUs(driver);
    });

    test('check-settings-contact-us', () async {
      await checkSettingsContactUs(driver);
    });

    test('check-settings-developers', () async {
      await checkSettingsDevelopers(driver);
    });

    test('check-settings-theme', () async {
      await checkSettingsTheme(driver);
    });
    test('check-logout', () async {
      await checkLogout(driver);
    });
  });

  tearDownAll(() async {
    await addDelay(300);
    await driver.close();
  });
}

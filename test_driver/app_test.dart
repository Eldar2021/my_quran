import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'helpers/helpers.dart';

void main() async {
  late FlutterDriver driver;

  group('Hatim App Integration Test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();

      await driver.waitUntilFirstFrameRasterized();
    });
  });

  test('login-select-lang-view', () async {
    await driver.waitFor(find.text('Please select Language'));

    await driver.tap(find.text('English'));
    await driver.tap(find.text('Кыргызча'));
    await driver.tap(find.text('English'));
    await takeScreenshot(driver, 'select-lang');
    await driver.tap(find.byValueKey('login-button'));
  });

  test('login-select-gender-view', () async {
    await driver.waitFor(find.text('Please select Gender'));

    await driver.tap(find.text('Male'));
    await driver.tap(find.text('Female'));
    await driver.tap(find.text('Male'));
    await takeScreenshot(driver, 'select-gender');
    await driver.tap(find.byValueKey('login-button'));
  });

  test('home-view', () async {
    await driver.waitFor(find.byValueKey('al-quran'));

    await takeScreenshot(driver, 'home-view');
    await driver.tap(find.byValueKey('home-view-button'));
  });

  test(
    'hatim-view',
    () async {
      await driver.waitFor(find.byValueKey('hatim-view'));

      await takeScreenshot(driver, 'hatim-view');
      await driver.tap(find.byValueKey('quran-view-1-juz'));
    },
    timeout: const Timeout(Duration(seconds: 120)),
  );

  test(
    'hatim-alert-view',
    () async {
      await driver.waitFor(find.text('Please select pages'));

      await takeScreenshot(driver, 'hatim-alert-view');
      await driver.tap(find.byValueKey('ok-button'));
      await driver.tap(find.byValueKey('quran-view-1-juz'));
      await driver.tap(find.byValueKey('cancel-button'));
      await driver.tap(find.pageBack());
      await driver.tap(find.byValueKey('quran'));
    },
    timeout: const Timeout(Duration(seconds: 120)),
  );

  test('quran-view', () async {
    await driver.waitFor(find.byValueKey('quran-view'));

    await takeScreenshot(driver, 'juz_items');
    await driver.tap(find.byValueKey('quran-view-1-juz'));
  });

  test(
    'read-view-1-juz',
    () async {
      await driver.waitFor(find.byValueKey('read-pages-list'));
    },
    timeout: const Timeout(Duration(seconds: 120)),
  );

  test('back-page', () async {
    await driver.tap(find.pageBack());
  });

  test('quran-view', () async {
    await driver.waitFor(find.byValueKey('quran-view'));

    await driver.tap(find.byValueKey('surah-items'));
    await takeScreenshot(driver, 'surah_items');
    await driver.tap(find.byValueKey('quran-view-2-surah'));
  });

  test(
    'read-baqarah',
    () async {
      await driver.waitFor(find.byValueKey('read-pages-list'));
      await takeScreenshot(driver, 'baqarah');
    },
    timeout: const Timeout(Duration(seconds: 120)),
  );

  test('back-page', () async {
    await driver.tap(find.pageBack());
  });

  test('settings-view', () async {
    await driver.waitFor(find.byValueKey('quran-view'));
    await driver.tap(find.byValueKey('profile'));
    await takeScreenshot(driver, 'settings-view');
  });

  test('settings-gender-view', () async {
    await driver.waitFor(find.byValueKey('settings-view'));
    await driver.tap(find.byValueKey('settings-gender-view'));
    await takeScreenshot(driver, 'settings-gender-view');
    await driver.tap(find.byValueKey('settings-gender-female-button'));
    await driver.tap(find.byValueKey('settings-gender-male-button'));
    await driver.tap(find.pageBack());
  });

  test('settings-language-view', () async {
    await driver.waitFor(find.byValueKey('settings-view'));
    await driver.tap(find.byValueKey('settings-language-view'));
    await takeScreenshot(driver, 'settings-language-view');
    await driver.tap(find.text('English'));
    await driver.tap(find.text('Кыргызча'));
    await driver.tap(find.text('English'));
    await driver.tap(find.pageBack());
  });

  test('settings-theme-view', () async {
    await driver.waitFor(find.byValueKey('settings-view'));
    await driver.tap(find.byValueKey('settings-theme-view'));

    await takeScreenshot(driver, 'settings-theme-view');
    await driver.tap(find.byValueKey('settings-theme-theme-button'));
    await takeScreenshot(driver, 'settings-theme-dark-view');
    await driver.tap(find.pageBack());
  });

  test('settings-about-us-view', () async {
    await driver.waitFor(find.byValueKey('settings-view'));
    await driver.tap(find.byValueKey('settings-about-us-view'));

    await takeScreenshot(driver, 'settings-about-us-view');
    await driver.tap(find.pageBack());
  });

  test('settings-feedback-view', () async {
    await driver.waitFor(find.byValueKey('settings-view'));
    await driver.tap(find.byValueKey('settings-feedback-view'));

    await takeScreenshot(driver, 'settings-feedback-view');
  });

  test('settings-developers-view', () async {
    await driver.waitFor(find.byValueKey('settings-view'));
    await driver.tap(find.byValueKey('settings-developers-view'));

    await takeScreenshot(driver, 'settings-developers-view');
    await driver.tap(find.pageBack());
    await driver.tap(find.byValueKey('home'));
  });

  tearDownAll(() async {
    await driver.close();
  });
}

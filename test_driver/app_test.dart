import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'helpers/helpers.dart';

void main() async {
  late FlutterDriver driver;

  group('EncointerWallet App', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();

      await driver.waitUntilFirstFrameRasterized();
    });
  });

  test('login-view', () async {
    await driver.waitFor(find.text('English'));

    await driver.tap(find.text('Кыргызча'));
    await addDelay(500);
    await driver.tap(find.text('English'));

    await driver.tap(find.byValueKey('login-female'));
    await takeScreenshot(driver, 'login');
    await driver.tap(find.byValueKey('start-login'));
  });

  test('home-view', () async {
    await driver.waitFor(find.byValueKey('juz-items'));
    await takeScreenshot(driver, 'juz_items');
    await driver.tap(find.byValueKey('surah-items'));
    await takeScreenshot(driver, 'surah_items');
    await driver.tap(find.byValueKey('2-surah'));
  });

  test(
    'read-baqarah',
    () async {
      await driver.waitFor(find.byValueKey('read-pages-list'));
      await driver.scroll(
        find.byValueKey('read-pages-list'),
        40,
        -1700,
        const Duration(seconds: 5),
      );
      await takeScreenshot(driver, 'baqarah');
    },
    timeout: const Timeout(Duration(seconds: 120)),
  );

  test('back-page', () async {
    await driver.tap(find.pageBack());
    await addDelay(1000);
  });

  tearDownAll(() async {
    await driver.close();
  });
}

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

  test('test localization', () async {
    await driver.waitFor(find.text('Language'));
    await takeScreenshot(driver, 'lang_name_en');
    await addDelay(1000);

    await driver.tap(find.text('Кыргызча'));
    await takeScreenshot(driver, 'lang_name_ky');
    await addDelay(1000);

    await driver.tap(find.text('Türkçe'));
    await takeScreenshot(driver, 'lang_name_tr');
    await addDelay(1000);

    await driver.tap(find.text('Қазақша'));
    await takeScreenshot(driver, 'lang_name_kk');
    await addDelay(1000);

    await driver.tap(find.text('Русский'));
    await addDelay(1000);
    await takeScreenshot(driver, 'lang_name_ru');

    await driver.tap(find.text('Indonesia'));
    await addDelay(1000);
    await takeScreenshot(driver, 'lang_name_id');

    await driver.tap(find.text('العربية'));
    await takeScreenshot(driver, 'lang_name_ar');
    await addDelay(1000);

    await driver.tap(find.text('English'));
    await addDelay(1000);
  });

  tearDownAll(() async {
    await driver.close();
  });
}

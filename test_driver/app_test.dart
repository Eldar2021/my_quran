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
    await addDelay(1000);
    await driver.waitFor(find.text('Language'));
    await addDelay(1000);
    await driver.tap(find.text('Кыргызча'));
    await addDelay(1000);
    await driver.tap(find.text('Türkçe'));
    await addDelay(1000);
    await driver.tap(find.text('Қазақша'));
    await addDelay(1000);
    await driver.tap(find.text('Русский'));
    await addDelay(1000);
    await driver.tap(find.text('Indonesia'));
    await addDelay(1000);
    await driver.tap(find.text('العربية'));
    await addDelay(1000);
    await driver.tap(find.text('English'));
    await addDelay(1000);
  });

  tearDownAll(() async {
    await driver.close();
  });
}

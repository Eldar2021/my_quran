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

  test('importing account', () async {
    await addDelay(1000);
    await driver.waitFor(find.text('Language'));
    await addDelay(1000);
    await driver.tap(find.text('ky'));
    await addDelay(1000);
    await driver.tap(find.text('kk'));
    await addDelay(1000);
    await driver.tap(find.text('tr'));
    await addDelay(1000);
    await driver.tap(find.text('ar'));
    await addDelay(1000);
    await driver.tap(find.text('ru'));
    await addDelay(1000);
  });

  tearDownAll(() async {
    await driver.close();
  });
}

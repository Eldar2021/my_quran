import 'package:flutter_driver/flutter_driver.dart';

import '../../extensions/extensions.dart';

Future<void> homeInit(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('al-quran'));
  await driver.takeScreenshot(Screenshots.homeInit);
}

import 'package:flutter_driver/flutter_driver.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import '../../extensions/extensions.dart';
import '../../helpers/helpers.dart';

Future<void> homeInit(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(MqKeys.alQuran));
  await addDelay(500);
  await driver.takeScreenshot(Screenshots.homeInit);
}

import 'package:flutter_driver/flutter_driver.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

Future<void> goBottomHome(FlutterDriver driver) async {
  await driver.tap(find.byValueKey(MqKeys.home));
}

Future<void> goBottomQuranRead(FlutterDriver driver) async {
  await driver.tap(find.byValueKey(MqKeys.quaranRead));
}

Future<void> goBottomQuranAudio(FlutterDriver driver) async {
  await driver.tap(find.byValueKey(MqKeys.quranAudio));
}

Future<void> goBottomSettings(FlutterDriver driver) async {
  await driver.tap(find.byValueKey(MqKeys.settings));
}

Future<void> backPage(FlutterDriver driver) async {
  await driver.tap(find.pageBack());
}

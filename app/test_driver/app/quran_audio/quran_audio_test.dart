import 'package:flutter_driver/flutter_driver.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import '../../extensions/extensions.dart';

Future<void> checkQuranAudioView(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(MqKeys.quranAudioView));
    await driver.waitFor(find.byValueKey(MqKeys.quranAudioBottomSheet));
    await driver.takeScreenshot(Screenshots.quranAudioInit);
  });
}

Future<void> playFatihaAndBaqara(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(MqKeys.quranAudioPlayPause));
    await driver.tap(find.byValueKey(MqKeys.quranAudioPlayPause));
    await Future<void>.delayed(const Duration(seconds: 5));
    await driver.takeScreenshot(Screenshots.quranAudioPlayFatiha);
    await driver.tap(find.byValueKey(MqKeys.quranAudioSurahIndex(1)));
    await Future<void>.delayed(const Duration(seconds: 5));
    await driver.takeScreenshot(Screenshots.quranAudioPlayBaqara);
    await driver.tap(find.byValueKey(MqKeys.quranAudioPlayPause));
    await Future<void>.delayed(const Duration(microseconds: 100));
  });
}

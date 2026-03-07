import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import '../../extensions/extensions.dart';
import '../../helpers/helpers.dart';

Future<void> checkQuranAudioView(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.quranAudioView)));
  await tester.waitFor(find.byKey(const Key(MqKeys.quranAudioBottomSheet)));
  await tester.takeScreenshot(Screenshots.quranAudioInit);
}

Future<void> playFatihaAndBaqara(WidgetTester tester) async {
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    await addDelay(3000);
    return;
  }
  await tester.waitFor(find.byKey(const Key(MqKeys.quranAudioPlayPause)));
  await tester.tap(find.byKey(const Key(MqKeys.quranAudioPlayPause)));
  await addDelay(5000);
  await tester.takeScreenshot(Screenshots.quranAudioPlayFatiha);
  await tester.tap(find.byKey(Key(MqKeys.quranAudioSurahIndex(1))));
  await addDelay(5000);
  await tester.takeScreenshot(Screenshots.quranAudioPlayBaqara);
  await tester.tap(find.byKey(const Key(MqKeys.quranAudioPlayPause)));
  await addDelay(100);
}

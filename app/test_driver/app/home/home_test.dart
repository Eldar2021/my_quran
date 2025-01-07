import 'package:flutter_driver/flutter_driver.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import '../../extensions/extensions.dart';
import '../../helpers/helpers.dart';

Future<void> homeInit(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(MqKeys.homeView));
    await addDelay(500);
    await driver.takeScreenshot(Screenshots.homeInit);
  });
}

Future<void> goToHatimPageFromHome(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.scrollUntilVisible(
      find.byValueKey(MqKeys.homeListView),
      find.byValueKey(MqKeys.participantToHatim),
      dyScroll: -100,
    );
    await driver.tap(find.byValueKey(MqKeys.participantToHatim));
  });
}

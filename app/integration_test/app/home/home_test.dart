import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import '../../extensions/extensions.dart';
import '../../helpers/helpers.dart';

Future<void> homeInit(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.homeView)));
  await addDelay(500);
  await tester.takeScreenshot(Screenshots.homeInit);
}

Future<void> goToHatimPageFromHome(WidgetTester tester) async {
  await tester.dragUntilVisible(
    find.byKey(const Key(MqKeys.participantToHatim)),
    find.byKey(const Key(MqKeys.homeListView)),
    const Offset(0, -100),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key(MqKeys.participantToHatim)));
  await tester.pumpAndSettle();
}

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import '../../extensions/extensions.dart';
import '../../helpers/helpers.dart';
import '../navigation.dart';

Future<void> goSettings(WidgetTester tester) async {
  await goBottomMore(tester);
  await tester.waitFor(find.byKey(const Key(MqKeys.settingsGenderLang)));
}

Future<void> checkSettingsView(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.settingsGenderLang)));
  await tester.takeScreenshot(Screenshots.settingsInit);
}

Future<void> checkSettingsGender(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.settingsGenderLang)));
  await tester.tap(find.byKey(const Key(MqKeys.settingsGenderLang)));
  await tester.waitFor(find.byKey(const Key(MqKeys.settingsGenderMale)));
  await tester.tap(find.byKey(const Key(MqKeys.settingsGenderMale)));
  await tester.pumpAndSettle();
  await tester.takeScreenshot(Screenshots.settingsGenderMale);
  await tester.tap(find.byKey(const Key(MqKeys.settingsGenderFemale)));
  await tester.pumpAndSettle();
  await tester.takeScreenshot(Screenshots.settingsGenderFemale);
  await backPage(tester);
}

Future<void> scrollToBottomFromMoreView(WidgetTester tester) async {
  await tester.dragUntilVisible(
    find.byKey(const Key(MqKeys.moreAppVersionTile)),
    find.byKey(const Key(MqKeys.moreListView)),
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
}

Future<void> checkSettingsAboutUs(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.settingsAboutUs)));
  await tester.tap(find.byKey(const Key(MqKeys.settingsAboutUs)));
  await tester.waitFor(find.byKey(const Key(MqKeys.settingsAboutUsPage)));
  await tester.takeScreenshot(Screenshots.settingsAboutUsPage);
  await backPage(tester);
}

Future<void> checkSettingsContactUs(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.settingsContactUs)));
  await tester.tap(find.byKey(const Key(MqKeys.settingsContactUs)));
  await tester.waitFor(find.byKey(const Key(MqKeys.settingsContactUsPage)));
  await tester.takeScreenshot(Screenshots.settingsContactUsPage);
  await backPage(tester);
}

Future<void> checkSettingsDevelopers(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.settingsDevelopers)));
  await tester.tap(find.byKey(const Key(MqKeys.settingsDevelopers)));
  await tester.waitFor(find.byKey(const Key(MqKeys.settingsDevelopersPage)));
  await tester.takeScreenshot(Screenshots.settingsDevelopersPage);
  await backPage(tester);
}

Future<void> checkSettingsTheme(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.settingsGenderLang)));
  await tester.tap(find.byKey(const Key(MqKeys.settingsGenderLang)));
  await tester.waitFor(find.byKey(Key(MqKeys.settingsThemeColorName('Orange'))));
  await tester.tap(find.byKey(Key(MqKeys.settingsThemeColorName('Orange'))));
  await tester.pumpAndSettle();
  await tester.takeScreenshot(Screenshots.settingsThemePageLightGreen);
  await tester.tap(find.byKey(Key(MqKeys.settingsThemeColorName('Blue'))));
  await tester.pumpAndSettle();
  await tester.takeScreenshot(Screenshots.settingsThemePageLightBlue);
  await backPage(tester);
}

Future<void> checkLogout(WidgetTester tester) async {
  await tester.waitFor(find.byKey(const Key(MqKeys.settingsGenderLang)));
  await tester.tap(find.byKey(const Key(MqKeys.logoutButton)));
  await tester.pumpAndSettle();
  await tester.takeScreenshot(Screenshots.logout);
}

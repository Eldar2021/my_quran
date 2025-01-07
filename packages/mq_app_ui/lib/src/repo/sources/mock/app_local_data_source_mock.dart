import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

@immutable
final class AppLocalDataSourceMock implements AppLocalDataSource {
  const AppLocalDataSourceMock();

  @override
  String appVersion() => '1.1.1';

  @override
  AppTheme initialTheme() => const AppOrangeTheme();

  @override
  Future<void> saveThemeMode({required bool isDark}) => Future.value();

  @override
  Future<void> saveThemePrimaryColor({required bool isOrange}) => Future.value();
}

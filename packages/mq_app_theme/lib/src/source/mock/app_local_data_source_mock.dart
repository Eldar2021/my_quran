import 'package:flutter/material.dart';
import 'package:mq_app_theme/mq_app_theme.dart';

@immutable
final class AppLocalDataSourceMock implements AppLocalDataSource {
  const AppLocalDataSourceMock();

  @override
  String appVersion() => '1.1.1';

  @override
  CustomTheme initialTheme() => const CustomTheme(Brightness.light, AppColors.red);

  @override
  Future<void> saveThemeMode({required bool isDark}) => Future.value();

  @override
  Future<void> saveThemePrimaryColor(int index) => Future.value();
}

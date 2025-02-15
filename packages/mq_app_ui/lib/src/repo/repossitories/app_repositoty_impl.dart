import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

@immutable
final class AppRepositoryImpl implements AppRepository {
  const AppRepositoryImpl(this.dataSource);

  final AppLocalDataSource dataSource;

  @override
  AppTheme getInitialThemeState() {
    return dataSource.initialTheme();
  }

  @override
  Future<void> saveThemeMode({required bool isDark}) {
    return dataSource.saveThemeMode(isDark: isDark);
  }

  @override
  Future<void> saveThemePrimaryColor({required bool isOrange}) {
    return dataSource.saveThemePrimaryColor(isOrange: isOrange);
  }
}

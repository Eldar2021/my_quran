import 'package:flutter/material.dart';
import 'package:mq_app_theme/mq_app_theme.dart';

@immutable
final class AppRepositoryImpl implements AppRepository {
  const AppRepositoryImpl();

  @override
  String appVersion() {
    throw UnimplementedError();
  }

  @override
  CustomTheme getInitialThemeState() {
    throw UnimplementedError();
  }

  @override
  Future<void> saveThemeMode({required bool isDark}) {
    throw UnimplementedError();
  }

  @override
  Future<void> saveThemePrimaryColor(int index) {
    throw UnimplementedError();
  }
}

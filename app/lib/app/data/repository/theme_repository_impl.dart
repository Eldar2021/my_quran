import 'package:flutter/material.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/theme/theme.dart';

@immutable
final class ThemeRepositoryImpl implements ThemeRepository {
  const ThemeRepositoryImpl(this.themeLocalDataSource);

  final ThemeLocalDataSource themeLocalDataSource;

  @override
  CustomTheme get getInitialThemeState => themeLocalDataSource.initialTheme;

  @override
  Future<void> saveThemePrimaryColor(int index) async {
    await themeLocalDataSource.saveThemePrimaryColor(index);
  }

  @override
  Future<void> saveThemeMode({required bool isDark}) async {
    await themeLocalDataSource.saveThemeMode(isDark: isDark);
  }
}

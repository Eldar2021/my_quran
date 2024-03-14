import 'package:flutter/material.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/theme/theme.dart';

@immutable
final class ThemeRepositoryImpl implements ThemeRepository {
  const ThemeRepositoryImpl(this.themeLocalDataSource);

  final ThemeLocalDataSource themeLocalDataSource;

  @override
  CustomTheme get getInitialThemeState {
    return themeLocalDataSource.initialTheme;
  }

  @override
  Future<void> setColor(int index) async {
    await themeLocalDataSource.setColor(index);
  }

  @override
  Future<void> setMode({required bool isDark}) async {
    await themeLocalDataSource.setMode(isDark: isDark);
  }
}

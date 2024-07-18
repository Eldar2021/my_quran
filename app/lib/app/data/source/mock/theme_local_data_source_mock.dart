import 'package:flutter/material.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/theme/theme.dart';

@immutable
final class ThemeLocalDataSourceMock implements ThemeLocalDataSource {
  const ThemeLocalDataSourceMock();

  @override
  CustomTheme get initialTheme {
    return const CustomTheme(Brightness.light, Colors.red);
  }

  @override
  Future<void> saveThemePrimaryColor(int index) async {}

  @override
  Future<void> saveThemeMode({required bool isDark}) async {}
}

import 'package:flutter/material.dart';
import 'package:mq_storage/mq_storage.dart';

import 'package:my_quran/theme/theme.dart';

class ThemeService {
  const ThemeService(this.storage);

  final PreferencesStorage storage;

  static const _modeKey = 'mode';
  static const _colorKey = 'color';

  CustomTheme init({bool isMale = false}) {
    final cacheTheme = storage.readString(key: _modeKey);
    final cacheColor = storage.readString(key: _colorKey);
    if (cacheTheme == 'dark') {
      return CustomTheme(Brightness.dark, _getColor(cacheColor, isMale: isMale));
    } else {
      return CustomTheme(Brightness.light, _getColor(cacheColor, isMale: isMale));
    }
  }

  Color _getColor(String? cacheColor, {required bool isMale}) {
    return cacheColor != null
        ? targetColors[int.parse(cacheColor)]!
        : isMale
            ? Colors.blue
            : Colors.red;
  }

  Future<void> setColor(int index) async {
    await storage.writeString(key: _colorKey, value: '$index');
  }

  Future<void> setMode({required bool isDark}) async {
    await storage.writeString(key: _modeKey, value: isDark ? 'dark' : 'light');
  }

  String get modeKey => _modeKey;
  String get colorKey => _colorKey;
}
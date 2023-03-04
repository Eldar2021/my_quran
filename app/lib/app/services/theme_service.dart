import 'package:flutter/material.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/constants/contants.dart';

import 'package:my_quran/theme/theme.dart';

class ThemeService {
  const ThemeService(this.storage);

  final PreferencesStorage storage;

  CustomTheme init() {
    final isDark = storage.readBool(key: AppConst.modeKey);
    final cachedColorIndex = storage.readInt(key: AppConst.colorKey);
    if (isDark ?? false) {
      return CustomTheme(Brightness.dark, _getColor(cachedColorIndex));
    } else {
      return CustomTheme(Brightness.light, _getColor(cachedColorIndex));
    }
  }

  Color _getColor(int? cacheColor) {
    return cacheColor != null ? targetColors[cacheColor]! : Colors.red;
  }

  Future<void> setColor(int index) async {
    await storage.writeInt(key: AppConst.colorKey, value: index);
  }

  Future<void> setMode({required bool isDark}) async {
    await storage.writeBool(key: AppConst.modeKey, value: isDark);
  }
}

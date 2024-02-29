import 'package:flutter/material.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/src/src.dart';
class ThemeService {
  const ThemeService(this.storage);

  final PreferencesStorage storage;

  CustomTheme get init {
    final isDark = storage.readBool(key: AppConst.modeKey);
    final cachedColorIndex = storage.readInt(key: AppConst.colorKey);
    return switch (isDark) {
      true => CustomTheme(Brightness.dark, _getColor(cachedColorIndex)),
      _ => CustomTheme(Brightness.light, _getColor(cachedColorIndex)),
    };
  }

  Color _getColor(int? cacheColor) {
    return TargetColor.fromIndex(cacheColor ?? 0).color;
  }

  Future<void> setColor(int index) async {
    await storage.writeInt(key: AppConst.colorKey, value: index);
  }

  Future<void> setMode({required bool isDark}) async {
    await storage.writeBool(key: AppConst.modeKey, value: isDark);
  }
}

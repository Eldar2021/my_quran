import 'package:flutter/material.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/theme/theme.dart';

@immutable
final class ThemeService {
  const ThemeService(this.storage);

  final PreferencesStorage storage;

  CustomTheme get init {
    final isDark = storage.readBool(key: StorageKeys.modeKey);
    final cachedColorIndex = storage.readInt(key: StorageKeys.colorKey);
    return switch (isDark) {
      true => CustomTheme(Brightness.dark, _getColor(cachedColorIndex)),
      _ => CustomTheme(Brightness.light, _getColor(cachedColorIndex)),
    };
  }

  Color _getColor(int? cacheColor) {
    return TargetColor.fromIndex(cacheColor ?? 0).color;
  }

  Future<void> setColor(int index) async {
    await storage.writeInt(key: StorageKeys.colorKey, value: index);
  }

  Future<void> setMode({required bool isDark}) async {
    await storage.writeBool(key: StorageKeys.modeKey, value: isDark);
  }
}

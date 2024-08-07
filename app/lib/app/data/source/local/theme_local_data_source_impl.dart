import 'package:flutter/material.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/theme/theme.dart';

@immutable
final class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  const ThemeLocalDataSourceImpl(this.storage);
  final PreferencesStorage storage;

  @override
  CustomTheme get initialTheme {
    final isDark = storage.readBool(key: StorageKeys.modeKey);
    final cachedColorIndex = storage.readInt(key: StorageKeys.colorKey);
    final brightness = (isDark ?? false) ? Brightness.dark : Brightness.light;
    final targetColor = _getColor(cachedColorIndex);
    return CustomTheme(brightness, targetColor);
  }

  @override
  Future<void> saveThemePrimaryColor(int index) async {
    await storage.writeInt(key: StorageKeys.colorKey, value: index);
  }

  @override
  Future<void> saveThemeMode({required bool isDark}) async {
    await storage.writeBool(key: StorageKeys.modeKey, value: isDark);
  }

  Color _getColor(int? cacheColor) {
    return TargetColor.fromIndex(cacheColor ?? 0).color;
  }
}

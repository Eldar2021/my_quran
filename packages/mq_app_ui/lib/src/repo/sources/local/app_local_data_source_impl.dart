import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_storage/mq_storage.dart';

@immutable
final class AppLocalDataSourceImpl implements AppLocalDataSource {
  const AppLocalDataSourceImpl(this.storage);

  final PreferencesStorage storage;

  static const _modeKey = 'mode';
  static const _colorKey = 'color';

  @override
  AppTheme initialTheme() {
    final isDark = storage.readBool(key: _modeKey);
    final isOrange = storage.readBool(key: _colorKey);
    if (isDark != null && isDark) {
      return switch (isOrange) {
        false => const AppBlueDarkTheme(),
        _ => const AppOrangeDarkTheme(),
      };
    } else {
      return switch (isOrange) {
        false => const AppBlueTheme(),
        _ => const AppOrangeTheme(),
      };
    }
  }

  @override
  Future<void> saveThemeMode({required bool isDark}) async {
    await storage.writeBool(key: _modeKey, value: isDark);
  }

  @override
  Future<void> saveThemePrimaryColor({required bool isOrange}) async {
    await storage.writeBool(key: _colorKey, value: isOrange);
  }
}

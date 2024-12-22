import 'package:flutter/material.dart';
import 'package:mq_app_theme/mq_app_theme.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

@immutable
final class AppLocalDataSourceImpl implements AppLocalDataSource {
  const AppLocalDataSourceImpl({
    required this.storage,
    required this.packageInfo,
  });

  final PreferencesStorage storage;
  final PackageInfo packageInfo;

  static const _modeKey = 'mode';
  static const _colorKey = 'color';

  @override
  String appVersion() => packageInfo.version;

  @override
  CustomTheme initialTheme() {
    final isDark = storage.readBool(key: _modeKey);
    final cachedColorIndex = storage.readInt(key: _colorKey);
    final brightness = (isDark ?? false) ? Brightness.dark : Brightness.light;
    final targetColor = _getColor(cachedColorIndex);
    return CustomTheme(brightness, targetColor);
  }

  @override
  Future<void> saveThemeMode({required bool isDark}) async {
    await storage.writeBool(key: _modeKey, value: isDark);
  }

  @override
  Future<void> saveThemePrimaryColor(int index) async {
    await storage.writeInt(key: _colorKey, value: index);
  }

  Color _getColor(int? cacheColor) {
    return TargetColor.fromIndex(cacheColor ?? 0).color;
  }
}

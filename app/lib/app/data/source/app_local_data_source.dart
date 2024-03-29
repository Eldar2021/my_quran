import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:package_info_plus/package_info_plus.dart';

@immutable
final class AppLocalDataSource {
  const AppLocalDataSource({
    required this.packageInfo,
    required this.storage,
  });

  final PreferencesStorage storage;
  final PackageInfo packageInfo;

  Locale get init {
    final code = storage.readString(key: StorageKeys.localeKey);
    if (code != null) return Locale(code);
    // ignore: deprecated_member_use
    final deviceLocal = window.locale.languageCode;
    return AppLocalizationHelper.getSupportedLocale(deviceLocal);
  }

  Future<Locale> setLocale(String langKey) async {
    await storage.writeString(key: StorageKeys.localeKey, value: langKey);
    return Locale(langKey);
  }

  String get appVersion => packageInfo.version;
}

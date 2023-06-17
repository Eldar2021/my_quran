import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/l10n/l10.dart';

@immutable
final class AppService {
  const AppService(this.storage);

  final PreferencesStorage storage;

  Locale get init {
    final code = storage.readString(key: AppConst.localeKey);
    if (code != null) return Locale(code);
    // ignore: deprecated_member_use
    final deviceLocal = window.locale.languageCode;
    return AppLocalizations.delegate.isSupported(Locale(deviceLocal)) ? Locale(deviceLocal) : const Locale('en');
  }

  Future<Locale> setLocale(String langKey) async {
    await storage.writeString(key: AppConst.localeKey, value: langKey);
    return Locale(langKey);
  }
}

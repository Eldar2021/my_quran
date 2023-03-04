import 'dart:ui';

import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/constants/contants.dart';

class AppService {
  const AppService(this.storage);

  final PreferencesStorage storage;

  static const String _localStorageLocaleKey = 'locale';

  Locale init() {
    final code = storage.readString(key: localStorageLocaleKey);
    if (code != null) {
      return Locale(code);
    } else {
      final deviceLocal = window.locale.languageCode;
      if (AppConst.isLocalSupport(deviceLocal)) {
        return Locale(deviceLocal);
      } else {
        return const Locale('en');
      }
    }
  }

  Future<Locale> setLocale(String langKey) async {
    await storage.writeString(key: localStorageLocaleKey, value: langKey);
    return Locale(langKey);
  }

  String get localStorageLocaleKey => _localStorageLocaleKey;
}

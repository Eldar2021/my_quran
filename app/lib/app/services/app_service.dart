import 'dart:ui';

import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/constants/contants.dart';

class AppService {
  const AppService(this.storage);

  final PreferencesStorage storage;

  Locale init() {
    final code = storage.readString(key: AppConst.localeKey);
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
    await storage.writeString(key: AppConst.localeKey, value: langKey);
    return Locale(langKey);
  }
}

import 'package:flutter/cupertino.dart';
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
      const deviceLocal = 'en'; //View.of(context).platformDispatcher.locale.languageCode;
      if (AppConst.isLocalSupport(deviceLocal)) {
        return const Locale(deviceLocal);
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

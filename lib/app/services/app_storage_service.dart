import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class AppStorageService {
  const AppStorageService(this.storage);

  final SharedPreferences storage;

  static const String _localStorageLocaleKey = 'locale';

  static const _locales = <Locale>[
    Locale('en'),
    Locale('ky'),
    Locale('tr'),
    Locale('kk'),
    Locale('ru'),
    Locale('id'),
    Locale('ar'),
  ];

  Locale init() {
    final code = storage.getString(localStorageLocaleKey);
    if (code != null) {
      return Locale(code);
    } else {
      final deviceLocal = window.locale.languageCode;
      if (_isSuuport(deviceLocal)) {
        return Locale(deviceLocal);
      } else {
        return const Locale('en');
      }
    }
  }

  Future<Locale> setLocale(int index) async {
    await storage.remove(localStorageLocaleKey);
    await storage.setString(localStorageLocaleKey, _locales[index].languageCode);
    return _locales[index];
  }

  bool _isSuuport(String deviceLocal) {
    switch (deviceLocal) {
      case 'en':
      case 'ky':
      case 'tr':
      case 'kk':
      case 'ru':
      case 'id':
      case 'ar':
        return true;
      default:
        return false;
    }
  }

  String getName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'ky':
        return 'Кыргызча';
      case 'tr':
        return 'Türkçe';
      case 'kk':
        return 'Қазақша';
      case 'ru':
        return 'Русский';
      case 'id':
        return 'Indonesia';
      case 'ar':
        return 'العربية';
      default:
        return 'English';
    }
  }

  String get localStorageLocaleKey => _localStorageLocaleKey;

  List<Locale> get locales => _locales;
}

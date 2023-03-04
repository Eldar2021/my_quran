import 'package:flutter/material.dart';

class AppConst {
  const AppConst._();

  static const String localStorageLocaleKey = 'locale';
  static const String tokenKey = 'token';
  static const String genderKey = 'gender';
  static const String usernameKey = 'username';
  // static const String totalHatim = 'total_hatim';
  // static const String totalRead = 'total_read';

  static const locales = <Locale>[
    Locale('en'),
    Locale('ky'),
    Locale('kk'),
    Locale('tr'),
    Locale('ar'),
    Locale('id'),
    Locale('ru'),
  ];

  static String getName(String code) {
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

  static bool isLocalSupport(String deviceLocal) {
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
}

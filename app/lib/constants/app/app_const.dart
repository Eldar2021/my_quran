import 'package:flutter/material.dart';

class AppConst {
  const AppConst._();

  static const localeKey = 'locale';
  static const tokenKey = 'token';
  static const genderKey = 'gender';
  static const usernameKey = 'username';
  static const modeKey = 'mode';
  static const colorKey = 'color';
  static const textSizeKey = 'textSize';
  static const verticalSpaceKey = 'verticalSpace';
  static const horizontallSaceKey = 'horizontallSace';
  static const modeIndexKey = 'modeIndex';

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
import 'package:flutter/material.dart';

class AppConst {
  const AppConst._();

  static const bismallah = 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ';

  static const localeKey = 'locale';
  static const tokenKey = 'token';
  static const genderKey = 'gender';
  static const usernameKey = 'username';
  static const modeKey = 'mode';
  static const readThemeKey = 'readThemeKey';
  static const colorKey = 'color';

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
    return switch (code) {
      'en' => 'English',
      'ky' => 'Кыргызча',
      'tr' => 'Türkçe',
      'kk' => 'Қазақша',
      'ru' => 'Русский',
      'id' => 'Indonesia',
      'ar' => 'العربية',
      _ => 'English',
    };
  }

  static bool isLocalSupport(String deviceLocal) {
    return switch (deviceLocal) {
      'en' || 'ky' || 'tr' || 'kk' || 'ru' || 'id' || 'ar' => true,
      _ => false,
    };
  }
}

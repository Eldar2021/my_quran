import 'package:flutter/material.dart';
import 'package:my_quran/config/app_config.dart';

class AppConst {
  const AppConst._();

  static const bismallah = 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ';

  static String get localeKey => apiConst.isDevmode ? _localeKeyDev : _localeKey;
  static String get tokenKey => apiConst.isDevmode ? _tokenKeyDev : _tokenKey;
  static String get genderKey => apiConst.isDevmode ? _genderKeyDev : _genderKey;
  static String get usernameKey => apiConst.isDevmode ? _usernameKeyDev : _usernameKey;
  static String get modeKey => apiConst.isDevmode ? _modeKeyDev : _modeKey;
  static String get readThemeKey => apiConst.isDevmode ? _readThemeKeyDev : _readThemeKey;
  static String get colorKey => apiConst.isDevmode ? _colorKeyDev : _colorKey;

  static const _localeKey = 'locale';
  static const _tokenKey = 'token';
  static const _genderKey = 'gender';
  static const _usernameKey = 'username';
  static const _modeKey = 'mode';
  static const _readThemeKey = 'readThemeKey';
  static const _colorKey = 'color';

  static const _localeKeyDev = 'locale-dev';
  static const _tokenKeyDev = 'token-dev';
  static const _genderKeyDev = 'gender-dev';
  static const _usernameKeyDev = 'username-dev';
  static const _modeKeyDev = 'mode-dev';
  static const _readThemeKeyDev = 'readThemeKey-dev';
  static const _colorKeyDev = 'color-dev';

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

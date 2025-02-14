import 'package:flutter/widgets.dart';
import 'package:my_quran/l10n/generated/app_localizations.dart';

export 'package:my_quran/l10n/generated/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

final class AppLocalizationHelper {
  const AppLocalizationHelper._();

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

  static bool isSupported(String locale) {
    return switch (locale) {
      'en' || 'ky' || 'tr' || 'kk' || 'ru' || 'id' || 'ar' => true,
      _ => false,
    };
  }

  static Locale getSupportedLocale(String locale) {
    if (isSupported(locale)) return Locale(locale);
    return const Locale('en');
  }
}

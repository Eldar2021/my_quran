part of 'mq_analytic.dart';

@immutable
final class AnalyticKey {
  const AnalyticKey._();

  // go - back
  static const goGenderPage = 'go-gender-page';
  static const goThemePage = 'go-theme-page';
  static const goAboutUsPage = 'go-about-us-page';
  static const goContactUsPage = 'go-contact-us-page';
  static const goDevelopersPage = 'go-developers-page';
  static const goDevMode = 'go-dev-mode';
  static const goHatim = 'go-hatim';
  static const goHatimReadPage = 'go-hatim-read-page';
  static const goQuranReadByJuz = 'go-quran-read-by-juz';
  static const goQuranReadBySurah = 'go-quran-read-by-surah';

  // select - unselect
  static const selectLanguage = 'select-language';
  static const selectGender = 'select-gender';
  static const selectThemeMode = 'select-theme-mode';
  static const selectThemeColor = 'select-theme-color';
  static const selectDevMode = 'select-dev-mode';
  static const selectPage = 'select-page';
  static const unselectPage = 'unselect-page';
  static const selectHatimJuz = 'select-hatim-juz';
  static const selectQuranAudioBySurah = 'select-quran-audio-by-surah';

  // action
  static const tapLogout = 'tap-logout';
  static const tapLoginWithSoccial = 'tap-login-with-soccial';
  static const tapPrivacyPolicy = 'tap-privacy-policy';
  static const tapQuranReadSettings = 'tap-quran-read-settings';
  static const showAmin = 'show-amin';

  // refresh
  static const refreshHomePage = 'refresh-home';
}

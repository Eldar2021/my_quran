part of 'mq_analytic.dart';

@immutable
final class AnalyticKey {
  const AnalyticKey._();

// login
  static const loginSelectLanguage = 'login-select-language';
  static const loginSelectGenderMale = 'login-select-gender-male';
  static const loginSelectGenderFemale = 'login-select-gender-female';
  static const loginGoogle = 'login-with-google';
  static const launchPrivacyPolicy = 'launch-privacy-policy';

  // home
  static const goHome = 'go-home';
  static const goHatim = 'go-hatim';

  // hatim
  static const readSelectedPages = 'read-selected-pages';
  static const selectPage = 'select-page';
  static const unselectPage = 'unselect-page';
  static const hatimSelectPageScroll = 'hatim-select-page-scroll';

  // quran
  static const quranReadJus = 'quran-read-jus';
  static const quranReadSurah = 'quran-read-surah';
  static const quranReadSettings = 'quran-read-settings';
  static const quranAudioSurah = 'quran-audio-surah';
  static const showAmin = 'show-amin';

  // Settings
  static const settingsGender = 'settings-gender';
  static const settingsLanguage = 'settings-language';
  static const settingsTheme = 'settings-theme';
  static const settingsAboutUs = 'settings-about-us';
  static const settingsContactUs = 'settings-contact-us';
  static const settingsDevelopers = 'settings-developers';
  static const settingsSelectGenderMale = 'settings-select-gender-male';
  static const settingsSelectGenderFemale = 'settings-select-gender-female';
  static const changeThemeMode = 'change-theme-mode';
  static const changeThemeColor = 'change-theme-color';
  static const logout = 'logout';
  static const goDevMode = 'go-dev-mode';
  static const setDevMode = 'set-dev-mode';
}

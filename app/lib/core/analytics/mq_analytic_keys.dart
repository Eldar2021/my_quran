part of 'mq_analytic.dart';

@immutable
final class AnalyticKey {
  const AnalyticKey._();

  // go - back
  static const goGenderPage = 'go_gender_page';
  static const goThemePage = 'go_theme_page';
  static const goAboutUsPage = 'go_about_us_page';
  static const goContactUsPage = 'go_contact_us_page';
  static const goDevelopersPage = 'go_developers_page';
  static const goDevMode = 'go_dev_mode';
  static const goHatim = 'go_hatim';
  static const goHatimReadPage = 'go_hatim_read_page';
  static const goQuranReadByJuz = 'go_quran_read_by_juz';
  static const goQuranReadBySurah = 'go_quran_read_by_surah';
  static const goVerificationOtp = 'go_verification_otp';

  // select - unselect
  static const selectLanguage = 'select_language';
  static const selectGender = 'select_gender';
  static const selectThemeMode = 'select_theme_mode';
  static const selectThemeColor = 'select_theme_color';
  static const selectDevMode = 'select_dev_mode';
  static const selectPage = 'select_page';
  static const unselectPage = 'unselect_page';
  static const selectHatimJuz = 'select_hatim_juz';
  static const selectQuranAudioBySurah = 'select_quran_audio_by_surah';

  // action
  static const tapLogout = 'tap_logout';
  static const tapDeleteAccount = 'tap_delete_account';
  static const tapLogin = 'tap_login';
  static const tapPrivacyPolicy = 'tap_privacy_policy';
  static const tapQuranReadSettings = 'tap_quran_read_settings';
  static const showAmin = 'show_amin';

  // refresh
  static const refreshHomePage = 'refresh_home';
}

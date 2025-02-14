final class MqKeys {
  // login
  static const loginInitial = 'login-initial';
  static const loginNext = 'login-next';
  static const signInView = 'sign-in-view';
  static const sendOtp = 'send-otp';
  static const verifyOtpView = 'verify-otp-view';
  static const emailTextField = 'email-text-field';
  static const otpTextField = 'otp-text-field';

  // home
  static const home = 'home';
  static const homeListView = 'home-list-view';
  static const homeView = 'home-view';
  static const allHatimCount = 'all-hatim-count';
  static const allReadedPageCount = 'all-readed-page-count';
  static const participantToHatim = 'participant-to-hatim';

  // hatim
  static const hatimPage = 'hatim-page';
  static const hatimJuzsList = 'hatim-juzs-list';
  static String hatimJuzIndex(int index) => 'hatim-juz-$index';
  static const hatimSelectPage = 'hatim-select-page';
  static const hatimSelectPageCancel = 'hatim-select-page-cancel';
  static const hatimSelectPageOk = 'hatim-select-page-ok';
  static const hatimSelectPageScroll = 'hatim-select-page-scroll-key';

  // quran-read
  static const quaranRead = 'qaran-read';
  static const quaranReadInitPage = 'qaran-read-init-page';
  static const quaranReadJuzs = 'qaran-read-juzs';
  static String quranReadJus(int index) => 'qaran-read-jus-$index';
  static const quaranReadSurahs = 'qaran-read-surahs';
  static String quranReadSurah(int index) => 'qaran-read-surah-$index';
  static const quranReadView = 'quran-read-view';
  static const quranReadSettings = 'quran-read-settings';
  static const quranReadSettingsBack = 'quran-read-settings-back';
  static const quranReadSettingsSave = 'quran-read-settings-save';

  // quran-audio
  static const quranAudio = 'quran-audio';
  static const quranAudioView = 'quran-audio-view';
  static String quranAudioSurahIndex(int index) => 'quran-audio-surah-$index';
  static const quranAudioBottomSheet = 'quran-audio-bottom-sheet';
  static const quranAudioPlayPause = 'quran-audio-play-pause';

  // settings
  static const settings = 'settings';
  static const settingsView = 'settings-view';
  static const settingsGenderLang = 'settings-gender-lang';
  static const settingsGenderLangPage = 'settings-gender-lang-page';
  static const settingsGenderMale = 'settings-gender-male';
  static const settingsGenderFemale = 'settings-gender-female';
  static const settingsTheme = 'settings-theme';
  static const settingsThemePage = 'settings-theme-page';
  static const settingsThemeLight = 'settings-theme-light';
  static const settingsThemeDark = 'settings-theme-dark';
  static String settingsThemeColorName(String name) => 'settings-theme-$name';
  static const settingsAboutUs = 'settings-about-us';
  static const settingsAboutUsPage = 'settings-about-us-page';
  static const settingsContactUs = 'settings-contact-us';
  static const settingsContactUsPage = 'settings-contact-us-page';
  static const settingsDevelopers = 'settings-developers';
  static const settingsDevelopersPage = 'settings-developers-page';
  static const String logoutButton = 'logout-button';
  static const String confirmLogoutButton = 'confirm-logout-button';
  static const String confirmLogoutButtonYes = 'confirm-logout-button-yes';
  static const String deleteAccountButton = 'delete-button';
  static const String confirmDeleteAccountButton = 'confirm-delete-account-button';

  // gender
  static const gender = 'gender';
  static String genderName(String name) => 'gender-$name';

  // login type
  static const loginType = 'login';
  static String loginTypeName(String name) => 'loginType-$name';

  // language
  static const language = 'language';
  static String languageCode(String localeCode) => 'language-$localeCode';

  // theme
  static const theme = 'theme';
  static String themeMode(String mode) => 'theme-$mode-mode';
  static String themeIndex(int index) => 'theme-index-$index';
}

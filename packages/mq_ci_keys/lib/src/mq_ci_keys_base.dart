final class MqKeys {
  // login
  static const loginSelectLeng = 'login-select-lang';
  static const loginNext = 'login-next';
  static const loginSelectGender = 'login-select-gender';

  // home
  static const home = 'home';
  static const alQuran = 'all-quran';
  static const allHatimCount = 'all-hatim-count';
  static const allReadedPageCount = 'all-readed-page-count';
  static const participantToHatim = 'participant-to-hatim';

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

  // quran-audio
  static const quranAudio = 'quran-audio';
  static const quranAudioView = 'quran-audio-view';
  static const quranAudioBottomSheet = 'quran-audio-bottom-sheet';
  static const quranAudioPlayPause = 'quran-audio-play-pause';

  // settings
  static const settings = 'settings';
  static const settingsView = 'settings-view';
  static const settingsGender = 'settings-gender';
  static const settingsGenderPage = 'settings-gender-page';
  static const settingsLanguage = 'settings-language';
  static const settingsLanguagePage = 'settings-language-page';
  static const settingsTheme = 'settings-theme';
  static const settingsThemePage = 'settings-theme-page';
  static const settingsAboutUs = 'settings-about-us';
  static const settingsAboutUsPage = 'settings-about-us-page';
  static const settingsContactUs = 'settings-contact-us';
  static const settingsContactUsPage = 'settings-contact-us-page';
  static const settingsDevelopers = 'settings-developers';
  static const settingsDevelopersPage = 'settings-developers-page';

  // gender
  static const gender = 'gender';
  static String genderName(String name) => 'gender-$name';

  // language
  static const language = 'language';
  static String languageCode(String localeCode) => 'language-$localeCode';

  // theme
  static const theme = 'theme';
  static String themeMode(String mode) => 'theme-$mode-mode';
  static String themeIndex(int index) => 'theme-index-$index';
}

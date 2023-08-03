class ApiConst {
  static const domain = 'http://quran.isistant.io/api/v1';
  static const signUp = '$domain/auth/sign_up';
  static const home = '$domain/report/dashboard';
  static const hatim = '$domain/hatim/join_to_hatim';

  static const socketBase = 'ws://quran.isistant.io/ws';

  static String juzSocket(String hatimId) => '/topic/$hatimId/list_of_juz';

  static String userPages(String username) => '/topic/$username/user_pages';

  static String getPagesByJuz(String juzId) => '/topic/$juzId/list_of_page';

  static const setInProgress = '/app/in_progress';
  static const setBook = '/app/book';
  static const setTodo = '/app/to_do';
  static const setDone = '/app/done';

  static Map<String, String> authMap(String token) => {'Authorization': 'Bearer $token'};

  static const urlGitHub = 'https://github.com/Eldar2021/my_quran';

  // TODO(eldiiar): Replace the privacy policy URL with the actual [URL] of your privacy policy page.
  static const provicyPolicy = 'https://github.com/Eldar2021/my_quran';

  static String verse(int page, String quranFmt) =>
      'https://api.quran.com/api/v4/quran/verses/$quranFmt?page_number=$page';
  static String audio(String surahIndex) =>
      'https://download.quranicaudio.com/quran/mishaari_raashid_al_3afaasee/$surahIndex.mp3';
}

class ApiConst {
  const ApiConst({
    required this.isDevmode,
    this.devDomain,
  });

  final bool isDevmode;
  final String? devDomain;

  static const domain = 'quran.isistant.io';

  String get baseUrl => 'http://$_getDomain/api/v1';
  String get signUp => '$baseUrl/auth/sign_up';
  String get home => '$baseUrl/report/dashboard';
  String get hatim => '$baseUrl/hatim/join_to_hatim';

  String get baseSocket => 'ws://$_getDomain/ws';
  String juzSocket(String hatimId) => '/topic/$hatimId/list_of_juz';
  String userPages(String username) => '/topic/$username/user_pages';
  String getPagesByJuz(String juzId) => '/topic/$juzId/list_of_page';
  String get setInProgress => '/app/in_progress';
  String get setBook => '/app/book';
  String get setTodo => '/app/to_do';
  String get setDone => '/app/done';

  Map<String, String> authMap(String token) => {'Authorization': 'Bearer $token'};

  String get _getDomain {
    if (isDevmode && devDomain != null && devDomain!.isNotEmpty) return devDomain!;
    return domain;
  }

  String verse(int page, String quranFmt) => 'https://api.quran.com/api/v4/quran/verses/$quranFmt?page_number=$page';
  String audio(String surahIndex) =>
      'https://download.quranicaudio.com/quran/mishaari_raashid_al_3afaasee/$surahIndex.mp3';

  String get urlGitHub => 'https://github.com/Eldar2021/my_quran';
  // TODO(eldiiar): Replace the privacy policy URL with the actual [URL] of your privacy policy page.
  String get provicyPolicy => 'https://github.com/Eldar2021/my_quran';
  String get appLogoLink => 'https://github.com/Eldar2021/my_quran/blob/main/app/assets/images/app_icon.png?raw=true';

  // ---------------------------------------------------
  static const newBase = 'https://myquran.life';
  String get loginWithGoogle => '$newBase/api/v1/accounts/google/';
  String putProfile(String userId) => '$newBase/api/v1/accounts/profile/$userId';
}

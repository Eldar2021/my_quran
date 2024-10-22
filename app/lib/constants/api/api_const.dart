class ApiConst {
  const ApiConst({
    required this.isDevmode,
    this.devDomain,
  });

  final bool isDevmode;
  final String? devDomain;

  static const domain = 'https://myquran.life';

  String get socketBase => 'wss://myquran.life/ws';
  String get loginEmailSend => '$_getDomain/api/v1/accounts/otp/send/';
  String get loginEmailVerify => '$_getDomain/api/v1/accounts/otp/verify/';
  String get loginWithGoogle => '$_getDomain/api/v1/accounts/google/';
  String get loginWithApple => '$_getDomain/api/v1/accounts/apple/';
  String get deleteProfile => '$_getDomain/api/v1/accounts/profile/delete_my_account/';
  String get nasaatMediaContinentsApi => 'http://165.232.39.64/api_places_times.php';
  String nasaatMediaNamazTimesApi(int placeId) => '$nasaatMediaContinentsApi?place_id=$placeId';
  String putProfile(String userId) => '$_getDomain/api/v1/accounts/profile/$userId/';
  String get hatimDashBoard => '$_getDomain/api/v1/hatim/dashboard';
  String get joinToHatim => '$_getDomain/api/v1/hatim/join_to_hatim';
  String getSocket(String token) => '$socketBase/?token=$token';

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
}

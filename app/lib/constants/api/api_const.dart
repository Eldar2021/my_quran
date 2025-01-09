class ApiConst {
  const ApiConst({this.devDomain});

  final String? devDomain;

  static const domain = 'https://myquran.life';

  String audio(String surahIndex) =>
      'https://download.quranicaudio.com/quran/mishaari_raashid_al_3afaasee/$surahIndex.mp3';

  String get urlGitHub => 'https://github.com/Eldar2021/my_quran';
  // TODO(eldiiar): Replace the privacy policy URL with the actual [URL] of your privacy policy page.
  String get provicyPolicy => 'https://github.com/Eldar2021/my_quran';
  static const appLogoLink =
      'https://github.com/Eldar2021/my_quran/blob/main/packages/mq_app_ui/assets/images/app_icon.png?raw=true';
}

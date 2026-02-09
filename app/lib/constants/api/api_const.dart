final class ApiConst {
  const ApiConst._();

  static const appName = 'MyQuran';

  static const domain = 'https://myquran.life';

  // 'https://download.quranicaudio.com/quran/mishaari_raashid_al_3afaasee/001.mp3';
  static String audio(String surahIndex, String? token) {
    final path = 'https://myquran.life/media/quran_audio/$surahIndex.mp3';
    if (token != null) return '$path?token=$token';
    return path;
  }

  static const urlGitHub = 'https://github.com/Eldar2021/my_quran';
  static const oneLink = 'https://onelink.to/q58a9t';
  // TODO(eldiiar): Replace the privacy policy URL with the actual [URL] of your privacy policy page.
  static const provicyPolicy = 'https://github.com/Eldar2021/my_quran';
  static const appLogoLink =
      'https://github.com/Eldar2021/my_quran/blob/main/packages/mq_app_ui/assets/images/app_icon.png?raw=true';
}

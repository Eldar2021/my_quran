abstract interface class QuranClientConstants {
  static String getNormalUrl(String path, String fileExtension) =>
      'https://myquran.life/media/fonts/normal_fonts/$path.$fileExtension';

  static String getTajweedUrl(String path, String fileExtension) =>
      'https://myquran.life/media/fonts/tajweed_fonts/$path.$fileExtension';
}

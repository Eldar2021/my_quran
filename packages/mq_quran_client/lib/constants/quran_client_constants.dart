abstract interface class QuranClientConstants {
  static String getNormalUrl(String path) {
    return 'https://media.githubusercontent.com/media/Eldar2021/eldar2021.github.io/refs/heads/main/my-quran/quran_data_v2/normal_fonts/$path.woff2?download=true';
  }

  static String getTajweedUrl(String path) {
    return 'https://media.githubusercontent.com/media/Eldar2021/eldar2021.github.io/refs/heads/main/my-quran/quran_data_v2/tajweed_fonts/$path.woff2?download=true';
  }
}

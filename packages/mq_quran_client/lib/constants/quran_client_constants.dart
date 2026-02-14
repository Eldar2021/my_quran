abstract interface class QuranClientConstants {
  String getFontByPageDownLoadUrl(int pageNumber) {
    return 'https://media.githubusercontent.com/media/Eldar2021/eldar2021.github.io/refs/heads/main/my-quran/quran_data_v2/normal_fonts/${_getPagePath(pageNumber)}.woff2?download=true';
  }

  String _getPagePath(int pageNumber) {
    return pageNumber.toString().padLeft(3, '0');
  }
}

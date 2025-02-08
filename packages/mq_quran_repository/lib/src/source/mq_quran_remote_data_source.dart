import 'package:mq_quran_repository/mq_quran_repository.dart';

abstract class MqQuranRemoteDataSource {
  Future<QuranPageResponse?> fetchPage(int page, String quranFmt);

  Future<QuranDataResponse> fetchQuranByPage(
    int pageNumber,
    String quranFmt,
  );

  Future<QuranDataResponse> fetchQuranByJuz(
    int juzNumber,
    String quranFmt,
  );

  Future<QuranDataResponse> fetchQuranBySurah(
    int surahNumber,
    String quranFmt,
  );
}

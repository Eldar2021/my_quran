import 'package:mq_quran_repository/mq_quran_repository.dart';

abstract class MqQuranLocalDataSource {
  List<JuzModelResponse> getJuzsData();

  List<SurahModelResponse> getSurahsData();

  QuranDataResponse? getQuranByPage(
    int pageNumber,
    String quranFmt,
  );

  QuranDataResponse? getQuranByJuz(
    int juzNumber,
    String quranFmt,
  );

  QuranDataResponse? getQuranBySurah(
    int surahNumber,
    String quranFmt,
  );

  Future<void> setQuranByPage(
    int pageNumber,
    String quranFmt,
    QuranDataResponse data,
  );

  Future<void> setQuranByJuz(
    int juzNumber,
    String quranFmt,
    QuranDataResponse data,
  );

  Future<void> setQuranBySurah(
    int surahNumber,
    String quranFmt,
    QuranDataResponse data,
  );
}

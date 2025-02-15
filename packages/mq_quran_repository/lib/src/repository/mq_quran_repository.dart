import 'package:mq_quran_repository/mq_quran_repository.dart';

abstract class MqQuranRepository {
  List<MqJuzEntity> getJuzsData();

  List<MqSurahEntity> getSurahsData();

  Future<QuranDataEntity> fetchQuranByPage(int pageNumber, String quranFmt);

  Future<QuranDataEntity> fetchQuranByJuz(int juzNumber, String quranFmt);

  Future<QuranDataEntity> fetchQuranBySurah(int surahNumber, String quranFmt);
}

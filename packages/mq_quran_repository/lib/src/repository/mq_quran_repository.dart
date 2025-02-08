import 'package:mq_quran_repository/mq_quran_repository.dart';

abstract class MqQuranRepository {
  List<JuzEntity> getJuzs();
  List<SurahEntity> getSurahs();
  Future<QuranPageEntity?> getPage(int page, String quranFmt);

  List<MqJuzEntity> getJuzsData();
  List<MqSurahEntity> getSurahsData();
}

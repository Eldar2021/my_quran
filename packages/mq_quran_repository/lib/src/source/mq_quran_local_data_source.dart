import 'package:mq_quran_repository/mq_quran_repository.dart';

abstract class MqQuranLocalDataSource {
  QuranPageResponse? getPage(int page, String quranFmt);
  Future<void> cachePage(int page, String quranFmt, QuranPageResponse pageData);
  List<JuzResponse> getJuzsFromLocal();
  List<SurahResponse> getSurahsFromLocal();

  List<JuzModelResponse> getJuzsData();
  List<SurahModelResponse> getSurahsData();
}

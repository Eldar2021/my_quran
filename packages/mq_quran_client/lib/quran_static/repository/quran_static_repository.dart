import 'package:mq_quran_client/mq_quran_client.dart';

abstract class QuranStaticRepository {
  List<QuranJuzModel> getJuzsData();

  List<QuranSurahModel> getSurahsData();
}

import 'package:mq_quran_client/mq_quran_client.dart';

abstract interface class QuranExtraLocalDataSoruce {
  List<QuranJuzModel> getJuzsData();

  List<QuranSurahModel> getSurahsData();
}

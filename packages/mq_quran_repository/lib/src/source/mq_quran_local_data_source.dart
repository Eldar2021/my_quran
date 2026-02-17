import 'package:mq_quran_repository/mq_quran_repository.dart';

abstract class MqQuranLocalDataSource {
  List<JuzModelResponse> getJuzsData();

  List<SurahModelResponse> getSurahsData();
}

import 'package:mq_quran_repository/mq_quran_repository.dart';

abstract class MqQuranRepository {
  List<MqJuzEntity> getJuzsData();

  List<MqSurahEntity> getSurahsData();

  Future<bool> setDonPages({
    required List<int> pageNumber,
    required String status,
    String? hatimId,
  });
}

import 'package:mq_quran_client/mq_quran_client.dart';

abstract interface class QuranExtraRepository {
  List<QuranJuzModel> getJuzsData();

  List<QuranSurahModel> getSurahsData();

  Future<bool> setDonPages({
    required List<int> pageNumber,
    required String status,
    String? hatimId,
  });
}

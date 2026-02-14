import 'package:mq_quran_client/mq_quran_client.dart';

abstract interface class QuranDataRepository {
  Future<List<QuranVerseModel>> getVersesByPage(
    int pageNumber, {
    int? sortSurahNumber,
    int? sortJuzNumber,
  });
}

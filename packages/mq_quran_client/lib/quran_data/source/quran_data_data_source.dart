import 'package:mq_quran_client/mq_quran_client.dart';

abstract interface class QuranDataDataSource {
  Future<List<QuranVerseModel>> getVersesByPage(int pageNumber);
}

import 'package:mq_quran_repository/mq_quran_repository.dart';

abstract class MqQuranRemoteDataSource {
  Future<QuranPageResponse?> fetchPage(int page, String quranFmt);
}

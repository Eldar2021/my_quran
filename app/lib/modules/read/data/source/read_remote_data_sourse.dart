import 'package:my_quran/modules/modules.dart';

abstract class ReadRemoteDataSource {
  Future<QuranPageResponse?> fetchPage(int page, String quranFmt);
}

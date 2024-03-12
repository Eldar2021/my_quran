import 'package:my_quran/modules/modules.dart';

abstract class ReadRepository {
  Future<QuranPageEntity?> getPage(int page, String quranFmt);
}

import 'package:my_quran/modules/modules.dart';

abstract class ReadLocalDataSource {
  QuranPageResponse? getPage(int page, String quranFmt);
  Future<void> cachePage(int page, String quranFmt, QuranPageResponse pageData);
}

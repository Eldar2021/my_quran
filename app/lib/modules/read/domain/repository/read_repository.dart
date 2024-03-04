import 'package:my_quran/modules/modules.dart';

abstract class ReadRepository {
  Future<QuranPage?> getPage(int page, String quranFmt);
}

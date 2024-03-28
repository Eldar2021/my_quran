import 'package:my_quran/modules/modules.dart';

abstract class QuranRepository {
  List<JuzEntity> getJuzs();
  List<SurahEntity> getSurahs();
}

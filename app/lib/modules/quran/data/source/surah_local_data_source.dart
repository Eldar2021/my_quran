import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class SurahLocalDataSource {
  List<SurahResponse> getSurahsFromLocal() {
    final surahs = surahData.map(SurahResponse.fromJson).toList();
    return surahs;
  }
}

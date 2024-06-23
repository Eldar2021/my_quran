import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class QuranAudioDataSource {
  List<SurahResponse> getSurahs() {
    final surahs = surahData.map(SurahResponse.fromJson).toList();
    return surahs;
  }
}

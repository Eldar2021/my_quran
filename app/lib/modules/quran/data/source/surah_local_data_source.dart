import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class SurahLocalDataSource {
  List<SurahEntity> getSurahsFromLocal() {
    final surahs = surahData.map((data) => _convertSurahData(SurahResponse.fromJson(data))).toList();
    return surahs;
  }

  SurahEntity _convertSurahData(SurahResponse response) {
    return SurahEntity(
      id: response.id,
      name: response.name,
      aya: response.aya,
      pages: response.pages,
      arabic: response.arabic,
    );
  }
}

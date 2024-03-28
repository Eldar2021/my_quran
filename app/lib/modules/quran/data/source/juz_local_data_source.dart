import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class JuzLocalDataSource {
  List<JuzEntity> getJuzsFromLocal() {
    final juzs = juzData.map((data) => _convertJuzData(JuzResponse.fromJson(data))).toList();
    return juzs;
  }

  JuzEntity _convertJuzData(JuzResponse response) {
    final convertedSurahs = response.surahs
        .map(
          (juzSurahResponse) => JuzSurahEntity(
            name: juzSurahResponse.name,
            arName: juzSurahResponse.arName,
            pages: juzSurahResponse.pages,
          ),
        )
        .toList();

    return JuzEntity(
      id: response.id,
      name: response.name,
      pages: response.pages,
      surahs: convertedSurahs,
    );
  }
}

import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class QuranRepositoryImpl implements QuranRepository {
  const QuranRepositoryImpl(
    this.juzLocalDataSource,
    this.surahLocalDataSource,
  );

  final JuzLocalDataSource juzLocalDataSource;
  final SurahLocalDataSource surahLocalDataSource;

  @override
  List<JuzEntity> getJuzs() {
    final juzResponses = juzLocalDataSource.getJuzsFromLocal();
    final juzEntities = juzResponses.map(_convertJuzData).toList();
    return juzEntities;
  }

  @override
  List<SurahEntity> getSurahs() {
    final surahResponses = surahLocalDataSource.getSurahsFromLocal();
    final surahEntities = surahResponses.map(_convertSurahData).toList();
    return surahEntities;
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

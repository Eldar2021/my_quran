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
    return juzLocalDataSource.getJuzsFromLocal();
  }

  @override
  List<SurahEntity> getSurahs() {
    return surahLocalDataSource.getSurahsFromLocal();
  }
}

import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class QuranAudioRepositoryImpl implements QuranAudioRepository {
  const QuranAudioRepositoryImpl(this.localDataSource);

  final QuranAudioDataSource localDataSource;

  @override
  List<SurahEntity> getSurahs() {
    final surahResponses = localDataSource.getSurahs();
    final surahEntities = surahResponses.map(_convertData).toList();
    return surahEntities;
  }

  SurahEntity _convertData(SurahResponse response) {
    return SurahEntity(
      id: response.id,
      name: response.name,
      aya: response.aya,
      pages: response.pages,
      arabic: response.arabic,
    );
  }
}

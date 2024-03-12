import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class ReadRepositoryImpl implements ReadRepository {
  const ReadRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
  );

  final ReadRemoteDataSource remoteDataSource;
  final ReadLocalDataSource localDataSource;

  @override
  Future<QuranPageEntity?> getPage(int page, String quranFmt) async {
    final cachedData = localDataSource.getPage(page, quranFmt);
    if (cachedData != null) return _convertData(cachedData);

    final data = await remoteDataSource.fetchPage(page, quranFmt);
    if (data != null) {
      await localDataSource.cachePage(page, quranFmt, data);
      return _convertData(data);
    } else {
      return null;
    }
  }

  QuranPageEntity _convertData(QuranPageResponse response) {
    return QuranPageEntity(
      meta: MetaEntity(FiltersEnity(response.meta.filters.pageNumber)),
      verses: response.verses
          .map(
            (e) => VerseEnity(
              id: e.id,
              verseKey: e.verseKey,
              textUthmani: e.textUthmani,
            ),
          )
          .toList(),
    );
  }
}

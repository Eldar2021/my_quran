import 'package:mq_quran_client/mq_quran_client.dart';

class QuranDataRepoImpl implements QuranDataRepository {
  QuranDataRepoImpl(this.source);

  final QuranDataDataSource source;

  final _cache = <int, Future<List<QuranVerseModel>>>{};

  @override
  Future<QuranPageModel> getVersesByPage(
    int pageNumber, {
    int? sortSurahNumber,
    int? sortJuzNumber,
  }) async {
    final data = await _getVerses(pageNumber);

    var filteredVerses = data;

    if (sortSurahNumber != null) {
      filteredVerses = filteredVerses.where((e) => e.chapterId == sortSurahNumber).toList();
    } else if (sortJuzNumber != null) {
      filteredVerses = filteredVerses.where((e) => e.juzNumber == sortJuzNumber).toList();
    }

    return QuranPageModel(
      pageNumber: pageNumber,
      verses: filteredVerses,
    );
  }

  Future<List<QuranVerseModel>> _getVerses(int pageNumber) {
    if (_cache.containsKey(pageNumber)) {
      return _cache[pageNumber]!;
    }

    final future = source.getVersesByPage(pageNumber).catchError((Object e) {
      _cache.remove(pageNumber);
      throw e;
    });

    _cache[pageNumber] = future;
    return future;
  }
}

import 'package:mq_quran_client/mq_quran_client.dart';

class QuranDataRepoImpl implements QuranDataRepository {
  QuranDataRepoImpl(this.source);

  final QuranDataDataSource source;

  final _cache = <int, Future<List<QuranVerseModel>>>{};

  @override
  Future<QuranPageModel> getVersesByPage(int pageNumber, {int? sortSurahNumber}) async {
    final data = await _getVerses(pageNumber);

    if (sortSurahNumber != null) {
      return QuranPageModel(
        pageNumber: pageNumber,
        verses: data.where((e) => e.chapterId == sortSurahNumber).toList(),
      );
    }

    return QuranPageModel(
      pageNumber: pageNumber,
      verses: data,
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

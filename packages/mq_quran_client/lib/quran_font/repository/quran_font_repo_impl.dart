import 'package:mq_quran_client/mq_quran_client.dart';

class QuranFontRepoImpl implements QuranFontRepository {
  QuranFontRepoImpl(this.source);

  final QuranFontSource source;

  final _cache = <int, Future<QuranFontModel>>{};

  @override
  Future<QuranFontModel> getFontByPage(int pageNumber) async {
    if (_cache.containsKey(pageNumber)) return _cache[pageNumber]!;

    final future = source.getFontByPage(pageNumber).catchError((Object error) {
      _cache.remove(pageNumber);
      throw error;
    });

    _cache[pageNumber] = future;
    return future;
  }
}

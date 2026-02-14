import 'dart:developer';

import 'package:mq_quran_client/mq_quran_client.dart';

class QuranFontRepoImpl implements QuranFontRepository {
  QuranFontRepoImpl(this.source);

  final QuranFontSource source;

  final _cache = <int, QuranFontModel>{};

  @override
  Future<QuranFontModel> getFontByPage(int pageNumber) async {
    if (_cache.containsKey(pageNumber)) return _cache[pageNumber]!;
    try {
      final font = await source.getFontByPage(pageNumber);
      _cache[pageNumber] = font;
      return font;
    } catch (e) {
      log('Get Font Error: $e');
      rethrow;
    }
  }
}

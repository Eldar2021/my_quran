import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:mq_storage/mq_storage.dart';

@immutable
final class MqQuranLocalDataSourceImpl implements MqQuranLocalDataSource {
  const MqQuranLocalDataSourceImpl(this.storage);

  final PreferencesStorage storage;

  @override
  QuranPageResponse? getPage(int page, String quranFmt) {
    final key = 'quran-$quranFmt-$page';
    final localValue = storage.readString(key: key);

    if (localValue != null) {
      final data = jsonDecode(localValue);
      return QuranPageResponse.fromJson(data as Map<String, dynamic>);
    }
    return null;
  }

  @override
  Future<void> cachePage(int page, String quranFmt, QuranPageResponse pageData) async {
    final key = 'quran-$quranFmt-$page';
    await storage.writeString(key: key, value: jsonEncode(pageData.toJson()));
  }

  @override
  List<JuzResponse> getJuzsFromLocal() {
    final juzs = juzData.map(JuzResponse.fromJson).toList();
    return juzs;
  }

  @override
  List<SurahResponse> getSurahsFromLocal() {
    final surahs = surahData.map(SurahResponse.fromJson).toList();
    return surahs;
  }
}

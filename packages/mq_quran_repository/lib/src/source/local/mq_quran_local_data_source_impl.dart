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

  /// New

  @override
  List<JuzModelResponse> getJuzsData() {
    final surahs = mqQuranJuzsData.map(JuzModelResponse.fromJson).toList();
    return surahs;
  }

  @override
  List<SurahModelResponse> getSurahsData() {
    final surahs = mqQuranSurahsData.map(SurahModelResponse.fromJson).toList();
    return surahs;
  }

  @override
  QuranDataResponse? getQuranByJuz(
    int juzNumber,
    String quranFmt,
  ) {
    final localValue = storage.readString(
      key: _juzKey(juzNumber, quranFmt),
    );

    if (localValue != null) {
      final data = jsonDecode(localValue);
      return QuranDataResponse.fromJson(data as Map<String, dynamic>);
    }
    return null;
  }

  @override
  QuranDataResponse? getQuranByPage(
    int pageNumber,
    String quranFmt,
  ) {
    final localValue = storage.readString(
      key: _pageKey(pageNumber, quranFmt),
    );

    if (localValue != null) {
      final data = jsonDecode(localValue);
      return QuranDataResponse.fromJson(data as Map<String, dynamic>);
    }
    return null;
  }

  @override
  QuranDataResponse? getQuranBySurah(
    int surahNumber,
    String quranFmt,
  ) {
    final localValue = storage.readString(
      key: _surahKey(surahNumber, quranFmt),
    );

    if (localValue != null) {
      final data = jsonDecode(localValue);
      return QuranDataResponse.fromJson(data as Map<String, dynamic>);
    }
    return null;
  }

  @override
  Future<void> setQuranByJuz(
    int juzNumber,
    String quranFmt,
    QuranDataResponse data,
  ) async {
    await storage.writeString(
      key: _juzKey(juzNumber, quranFmt),
      value: jsonEncode(data.toJson()),
    );
  }

  @override
  Future<void> setQuranByPage(
    int pageNumber,
    String quranFmt,
    QuranDataResponse data,
  ) async {
    await storage.writeString(
      key: _pageKey(pageNumber, quranFmt),
      value: jsonEncode(data.toJson()),
    );
  }

  @override
  Future<void> setQuranBySurah(
    int surahNumber,
    String quranFmt,
    QuranDataResponse data,
  ) async {
    await storage.writeString(
      key: _surahKey(surahNumber, quranFmt),
      value: jsonEncode(data.toJson()),
    );
  }

  String _surahKey(int surahNumber, String quranFmt) {
    return 'quran-by-surah-$quranFmt-$surahNumber';
  }

  String _juzKey(int juzNumber, String quranFmt) {
    return 'quran-by-juz-$quranFmt-$juzNumber';
  }

  String _pageKey(int pageNumber, String quranFmt) {
    return 'quran-by-page-$quranFmt-$pageNumber';
  }
}

import 'package:flutter/material.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

@immutable
final class MqQuranLocalDataSourceMock implements MqQuranLocalDataSource {
  const MqQuranLocalDataSourceMock();

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
  QuranDataResponse? getQuranByJuz(int juzNumber, String quranFmt) {
    return null;
  }

  @override
  QuranDataResponse? getQuranByPage(int pageNumber, String quranFmt) {
    return null;
  }

  @override
  QuranDataResponse? getQuranBySurah(int surahNumber, String quranFmt) {
    return null;
  }

  @override
  Future<void> setQuranByJuz(int juzNumber, String quranFmt, QuranDataResponse data) {
    return Future.value();
  }

  @override
  Future<void> setQuranByPage(int pageNumber, String quranFmt, QuranDataResponse data) {
    return Future.value();
  }

  @override
  Future<void> setQuranBySurah(int surahNumber, String quranFmt, QuranDataResponse data) {
    return Future.value();
  }
}

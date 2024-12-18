import 'package:flutter/material.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

@immutable
final class MqQuranLocalDataSourceMock implements MqQuranLocalDataSource {
  const MqQuranLocalDataSourceMock();

  @override
  QuranPageResponse? getPage(int page, String quranFmt) => null;

  @override
  Future<void> cachePage(int page, String quranFmt, QuranPageResponse pageData) => Future.value();

  @override
  List<JuzResponse> getJuzsFromLocal() => [];

  @override
  List<SurahResponse> getSurahsFromLocal() => [];
}

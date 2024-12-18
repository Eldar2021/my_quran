import 'package:flutter/material.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

@immutable
final class MqQuranRepositoryImpl implements MqQuranRepository {
  const MqQuranRepositoryImpl(
    this.localDataSource,
    this.remoteDataSource,
  );

  final MqQuranLocalDataSource localDataSource;
  final MqQuranRemoteDataSource remoteDataSource;

  @override
  List<JuzEntity> getJuzs() {
    final juzResponses = localDataSource.getJuzsFromLocal();
    final juzEntities = juzResponses.map(_convertJuzData).toList();
    return juzEntities;
  }

  @override
  List<SurahEntity> getSurahs() {
    final surahResponses = localDataSource.getSurahsFromLocal();
    final surahEntities = surahResponses.map(_convertSurahData).toList();
    return surahEntities;
  }

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

  JuzEntity _convertJuzData(JuzResponse response) {
    final convertedSurahs = response.surahs
        .map(
          (juzSurahResponse) => JuzSurahEntity(
            name: juzSurahResponse.name,
            arName: juzSurahResponse.arName,
            pages: juzSurahResponse.pages,
          ),
        )
        .toList();

    return JuzEntity(
      id: response.id,
      name: response.name,
      pages: response.pages,
      surahs: convertedSurahs,
    );
  }

  SurahEntity _convertSurahData(SurahResponse response) {
    return SurahEntity(
      id: response.id,
      name: response.name,
      aya: response.aya,
      pages: response.pages,
      arabic: response.arabic,
    );
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

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
  List<MqJuzEntity> getJuzsData() {
    final juzResponses = localDataSource.getJuzsData();
    final juzEntities = juzResponses.map((e) => e.toEntity()).toList();
    return juzEntities;
  }

  @override
  List<MqSurahEntity> getSurahsData() {
    final surahResponses = localDataSource.getSurahsData();
    final surahEntities = surahResponses.map((e) => e.toEntity()).toList();
    return surahEntities;
  }

  @override
  Future<QuranDataEntity> fetchQuranByJuz(
    int juzNumber,
    String quranFmt,
  ) async {
    // final cachedData = localDataSource.getQuranByJuz(
    //   juzNumber,
    //   quranFmt,
    // );

    // if (cachedData != null) return cachedData.toEntity();

    final data = await remoteDataSource.fetchQuranByJuz(
      juzNumber,
      quranFmt,
    );

    // await localDataSource.setQuranByJuz(
    //   juzNumber,
    //   quranFmt,
    //   data,
    // );

    return data.toEntity();
  }

  @override
  Future<QuranDataEntity> fetchQuranByPage(
    int pageNumber,
    String quranFmt,
  ) async {
    // final cachedData = localDataSource.getQuranByPage(
    //   pageNumber,
    //   quranFmt,
    // );

    // if (cachedData != null) return cachedData.toEntity();

    final data = await remoteDataSource.fetchQuranByPage(
      pageNumber,
      quranFmt,
    );

    // await localDataSource.setQuranByPage(
    //   pageNumber,
    //   quranFmt,
    //   data,
    // );

    return data.toEntity();
  }

  @override
  Future<QuranDataEntity> fetchQuranBySurah(
    int surahNumber,
    String quranFmt,
  ) async {
    // final cachedData = localDataSource.getQuranBySurah(
    //   surahNumber,
    //   quranFmt,
    // );

    // if (cachedData != null) return cachedData.toEntity();

    final data = await remoteDataSource.fetchQuranBySurah(
      surahNumber,
      quranFmt,
    );

    // await localDataSource.setQuranBySurah(
    //   surahNumber,
    //   quranFmt,
    //   data,
    // );

    return data.toEntity();
  }
}

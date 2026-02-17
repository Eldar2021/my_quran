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
  Future<bool> setDonPages({
    required List<int> pageNumber,
    required String status,
    String? hatimId,
  }) {
    return remoteDataSource.setDonPages(
      pageNumber: pageNumber,
      hatimId: hatimId,
      status: status,
    );
  }
}

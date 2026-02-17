import 'package:flutter/material.dart';
import 'package:mq_quran_client/mq_quran_client.dart';

@immutable
final class QuranExtraRepoImpl implements QuranExtraRepository {
  const QuranExtraRepoImpl({
    required this.remoteDataSource,
    required this.localDataSoruce,
  });

  final QuranExtraRemoteDataSource remoteDataSource;
  final QuranExtraLocalDataSoruce localDataSoruce;

  @override
  List<QuranJuzModel> getJuzsData() {
    return localDataSoruce.getJuzsData();
  }

  @override
  List<QuranSurahModel> getSurahsData() {
    return localDataSoruce.getSurahsData();
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

import 'package:flutter/material.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

@immutable
final class MqQuranRepositoryImpl implements MqQuranRepository {
  const MqQuranRepositoryImpl(this.remoteDataSource);

  final MqQuranRemoteDataSource remoteDataSource;

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

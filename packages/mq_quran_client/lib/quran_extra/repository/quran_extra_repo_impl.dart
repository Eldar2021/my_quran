import 'package:flutter/material.dart';
import 'package:mq_quran_client/mq_quran_client.dart';

@immutable
final class QuranExtraRepoImpl implements QuranExtraRepository {
  const QuranExtraRepoImpl(this.remoteDataSource);

  final QuranExtraRemoteDataSource remoteDataSource;

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

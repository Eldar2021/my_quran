import 'package:flutter/material.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

@immutable
final class MqQuranRemoteDataSourceImpl implements MqQuranRemoteDataSource {
  const MqQuranRemoteDataSourceImpl(this.remoteClient);

  final MqRemoteClient remoteClient;

  @override
  Future<QuranPageResponse?> fetchPage(int page, String quranFmt) async {
    final remoteValue = await remoteClient.getType<QuranPageResponse>(
      'https://api.quran.com/api/v4/quran/verses/$quranFmt?page_number=$page',
      fromJson: QuranPageResponse.fromJson,
    );

    return remoteValue.fold(
      (l) => throw Exception('Failed to fetch remote data $l'),
      (r) => r,
    );
  }
}

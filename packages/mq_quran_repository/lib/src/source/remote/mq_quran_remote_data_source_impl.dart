import 'package:flutter/material.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

@immutable
final class MqQuranRemoteDataSourceImpl implements MqQuranRemoteDataSource {
  const MqQuranRemoteDataSourceImpl(this.remoteClient);

  final MqRemoteClient remoteClient;

  @override
  Future<QuranDataResponse> fetchQuranByJuz(
    int juzNumber,
    String quranFmt,
  ) async {
    final remoteValue = await remoteClient.getType<QuranDataResponse>(
      'https://api.quran.com/api/v4/quran/verses/$quranFmt?juz_number=$juzNumber',
      fromJson: QuranDataResponse.fromJson,
    );

    return remoteValue.fold(
      (l) => throw Exception('Failed to fetch remote data $l'),
      (r) => r,
    );
  }

  @override
  Future<QuranDataResponse> fetchQuranByPage(
    int pageNumber,
    String quranFmt,
  ) async {
    final remoteValue = await remoteClient.getType<QuranDataResponse>(
      'https://api.quran.com/api/v4/quran/verses/$quranFmt?page_number=$pageNumber',
      fromJson: QuranDataResponse.fromJson,
    );

    return remoteValue.fold(
      (l) => throw Exception('Failed to fetch remote data $l'),
      (r) => r,
    );
  }

  @override
  Future<QuranDataResponse> fetchQuranBySurah(
    int surahNumber,
    String quranFmt,
  ) async {
    final remoteValue = await remoteClient.getType<QuranDataResponse>(
      'https://api.quran.com/api/v4/quran/verses/$quranFmt?chapter_number=$surahNumber',
      fromJson: QuranDataResponse.fromJson,
    );

    return remoteValue.fold(
      (l) => throw Exception('Failed to fetch remote data $l'),
      (r) => r,
    );
  }
}

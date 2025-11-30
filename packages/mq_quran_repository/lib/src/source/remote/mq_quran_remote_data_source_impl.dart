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
  ) {
    return remoteClient.getType<QuranDataResponse>(
      'https://api.quran.com/api/v4/quran/verses/$quranFmt?juz_number=$juzNumber',
      fromJson: QuranDataResponse.fromJson,
    );
  }

  @override
  Future<QuranDataResponse> fetchQuranByPage(
    int pageNumber,
    String quranFmt,
  ) {
    return remoteClient.getType<QuranDataResponse>(
      'https://api.quran.com/api/v4/quran/verses/$quranFmt?page_number=$pageNumber',
      fromJson: QuranDataResponse.fromJson,
    );
  }

  @override
  Future<QuranDataResponse> fetchQuranBySurah(
    int surahNumber,
    String quranFmt,
  ) {
    return remoteClient.getType<QuranDataResponse>(
      'https://api.quran.com/api/v4/quran/verses/$quranFmt?chapter_number=$surahNumber',
      fromJson: QuranDataResponse.fromJson,
    );
  }
}

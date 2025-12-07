import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

@immutable
final class MqQuranRemoteDataSourceImpl implements MqQuranRemoteDataSource {
  const MqQuranRemoteDataSourceImpl(this.remoteClient);

  final MqRemoteClient remoteClient;

  @override
  Future<String> getToken(
    String clientId,
    String clientSecret,
  ) async {
    final basicAuth = 'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}';
    final data = await remoteClient.post<Map<String, dynamic>>(
      'https://prelive-oauth2.quran.foundation/oauth2/token',
      headers: {
        'Authorization': basicAuth,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: 'grant_type=client_credentials&scope=content',
    );
    return data['access_token'] as String;
  }

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

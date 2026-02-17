import 'package:flutter/material.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

@immutable
final class MqQuranRemoteDataSourceImpl implements MqQuranRemoteDataSource {
  const MqQuranRemoteDataSourceImpl(this.remoteClient);

  final MqRemoteClient remoteClient;

  @override
  Future<bool> setDonPages({
    required List<int> pageNumber,
    required String status,
    String? hatimId,
  }) async {
    final response = await remoteClient.postResponse<dynamic>(
      'https://myquran.life/api/v1/hatim/pages_status',
      body: <String, dynamic>{
        'pageNumber': pageNumber,
        'hatimId': hatimId,
        'status': status,
      },
    );
    return response.statusCode == 200;
  }
}

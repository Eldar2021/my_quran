import 'package:flutter/material.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

@immutable
final class MqHomeRemoteDataSourceImpl implements MqHomeRemoteDataSource {
  const MqHomeRemoteDataSourceImpl(this.remoteClient);

  final MqRemoteClient remoteClient;

  @override
  Future<MqHomeModelResponse> getRemoteData() async {
    final remoteValue = await remoteClient.getType<MqHomeModelResponse>(
      '/api/v1/hatim/dashboard',
      fromJson: MqHomeModelResponse.fromJson,
    );

    return remoteValue.fold(
      (left) => throw Exception('Failed to fetch remote data $left'),
      (right) => right,
    );
  }

  @override
  Future<List<MqStoryModelResponse>> getStories(String language) async {
    final remoteValue = await remoteClient.getListOfType<MqStoryModelResponse>(
      'https://eldar2021.github.io/my-quran/stories/$language/my-quran-stories.json',
      fromJson: MqStoryModelResponse.fromJson,
    );

    return remoteValue.fold(
      (left) => throw Exception('Failed to fetch remote data $left'),
      (right) => right,
    );
  }
}

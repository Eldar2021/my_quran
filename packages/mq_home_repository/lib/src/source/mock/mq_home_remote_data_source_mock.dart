import 'package:flutter/material.dart';
import 'package:mq_home_repository/mq_home_repository.dart';

@immutable
final class MqHomeRemoteDataSourceMock implements MqHomeRemoteDataSource {
  const MqHomeRemoteDataSourceMock();

  @override
  Future<MqHomeModelResponse> getRemoteData() async {
    return const MqHomeModelResponse(
      allDoneHatims: 0,
      allDonePages: 0,
      donePages: 0,
    );
  }

  @override
  Future<List<MqStoryModelResponse>> getStories(String language) async {
    return mqStoriesMock
        .map(
          (e) => MqStoryModelResponse.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}

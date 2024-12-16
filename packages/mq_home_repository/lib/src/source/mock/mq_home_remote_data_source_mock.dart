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
}

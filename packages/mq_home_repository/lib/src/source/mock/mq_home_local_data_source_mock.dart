import 'package:flutter/material.dart';
import 'package:mq_home_repository/mq_home_repository.dart';

@immutable
final class MqHomeLocalDataSourceMock implements MqHomeLocalDataSource {
  const MqHomeLocalDataSourceMock();

  @override
  MqHomeModelResponse getLocalData() {
    return const MqHomeModelResponse(allDoneHatims: 0, allDonePages: 0, donePages: 0);
  }

  @override
  Future<void> saveLocalData(MqHomeModelResponse data) => Future.value();
}

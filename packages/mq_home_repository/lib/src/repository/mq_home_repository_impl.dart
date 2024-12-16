import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:mq_home_repository/mq_home_repository.dart';

@immutable
final class MqHomeRepositoryImpl implements MqHomeRepository {
  const MqHomeRepositoryImpl(
    this.localDataSource,
    this.remoteDataSource,
  );

  final MqHomeLocalDataSource localDataSource;
  final MqHomeRemoteDataSource remoteDataSource;

  @override
  Future<MqHomeEntity> getData() async {
    try {
      final remoteData = await remoteDataSource.getRemoteData();
      await localDataSource.saveLocalData(remoteData);
      return _convertData(remoteData);
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      log('HomeRepositoryImpl, getData error: $e');
      return _convertData(localDataSource.getLocalData());
    }
  }

  MqHomeEntity _convertData(MqHomeModelResponse response) {
    return MqHomeEntity(
      allDoneHatims: response.allDoneHatims,
      allDonePages: response.allDonePages,
      donePages: response.donePages,
    );
  }
}

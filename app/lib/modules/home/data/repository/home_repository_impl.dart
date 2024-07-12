import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(
    this.localDataSource,
    this.remoteDataSource,
  );

  final HomeLocalDataSource localDataSource;
  final HomeRemoteDataSource remoteDataSource;

  @override
  Future<HomeEntity> getData() async {
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

  HomeEntity _convertData(HomeModelResponse response) {
    return HomeEntity(
      allDoneHatims: response.allDoneHatims,
      allDonePages: response.allDonePages,
      donePages: response.donePages,
    );
  }
}

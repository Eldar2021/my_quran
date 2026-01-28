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
  Future<MqHomeModel> getData() async {
    try {
      final remoteData = await remoteDataSource.getRemoteData();
      await localDataSource.saveLocalData(remoteData);
      return remoteData;
    } on Object catch (e, s) {
      MqCrashlytics.report(e, s);
      log('HomeRepositoryImpl, getData error: $e');
      return localDataSource.getLocalData();
    }
  }

  @override
  Future<List<MqStoryEntity>> getStories(String language) async {
    try {
      final remoteData = await remoteDataSource.getStories(language);
      return remoteData.map((e) => e.toEntity()).toList();
    } on Object catch (e, s) {
      MqCrashlytics.report(e, s);
      log('HomeRepositoryImpl, getStories error: $e');
      final items = mqStoriesMock.map(MqStoryModelResponse.fromJson).toList();
      return items.map((e) => e.toEntity()).toList();
    }
  }

  @override
  Future<MqDonationPageEntity> getDonationPageData() async {
    try {
      final remoteData = await remoteDataSource.getDonationPageData();
      return remoteData.toEntity();
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      log('HomeRepositoryImpl, getData error: $e');
      throw Exception(e);
    }
  }

  @override
  Future<void> hatimAccept(String id) async {
    await remoteDataSource.hatimAccept(id);
  }

  @override
  Future<void> hatimReject(String id) async {
    await remoteDataSource.hatimReject(id);
  }
}

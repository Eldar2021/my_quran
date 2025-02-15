import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:mq_home_repository/mq_home_repository.dart';

@immutable
final class MqHomeRepositoryImpl implements MqHomeRepository {
  const MqHomeRepositoryImpl(this.localDataSource, this.remoteDataSource);

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

  @override
  Future<List<MqStoryEntity>> getStories(String language) async {
    try {
      final remoteData = await remoteDataSource.getStories(language);
      return remoteData.map((e) => e.toEntity()).toList();
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      log('HomeRepositoryImpl, getStories error: $e');
      final items = mqStoriesMock.map((e) => MqStoryModelResponse.fromJson(e as Map<String, dynamic>)).toList();
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
  Future<List<MqHomeBannerEntity>> getHomeBanners() async {
    try {
      final now = DateTime.now();
      final remoteData = await remoteDataSource.getHomeBanners();
      await localDataSource.setHomeBanners(remoteData);
      final data = remoteData.map((e) => e.toEntity()).toList();
      final list = List<MqHomeBannerEntity>.from(
        data..removeWhere((e) {
          if (e.hasCondition && e.date != null) {
            final date = DateTime.parse(e.date ?? '2012-02-27');
            return !_isSameDate(now, date);
          } else {
            return false;
          }
        }),
      );

      return list;
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      log('HomeRepositoryImpl, getData error: $e');
      final banners = localDataSource.getHomeBanners();
      return banners.map((e) => e.toEntity()).toList();
    }
  }

  bool _isSameDate(DateTime now, DateTime date) {
    return now.year == date.year && now.month == date.month && now.day == date.day;
  }
}

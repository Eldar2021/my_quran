import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:mq_storage/mq_storage.dart';

@immutable
final class MqHomeLocalDataSourceImpl implements MqHomeLocalDataSource {
  const MqHomeLocalDataSourceImpl(this.storage);

  final PreferencesStorage storage;

  static const _homeDataCacheKey = 'home-model';

  static const _storiesCacheKey = 'stories';

  @override
  MqHomeModelResponse getLocalData() {
    final localValue = storage.readString(key: _homeDataCacheKey);
    if (localValue != null) {
      final data = jsonDecode(localValue);
      return MqHomeModelResponse.fromJson(data as Map<String, dynamic>);
    } else {
      return const MqHomeModelResponse(
        allDoneHatims: 0,
        allDonePages: 0,
        donePages: 0,
      );
    }
  }

  @override
  Future<void> saveLocalData(MqHomeModelResponse data) async {
    await storage.writeString(
      key: _homeDataCacheKey,
      value: jsonEncode(data.toJson()),
    );
  }

  @override
  List<MqStoryModelResponse> getStories(String language) {
    final localValue = storage.readString(key: '$_storiesCacheKey-$language');
    final data = localValue != null ? jsonDecode(localValue) as List<dynamic> : mqStoriesMock;
    return data.map((e) => MqStoryModelResponse.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> saveStories(
    List<MqStoryModelResponse> data,
    String language,
  ) async {
    await storage.writeString(
      key: '$_storiesCacheKey-$language',
      value: jsonEncode(data.map((e) => e.toJson()).toList),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  const HomeLocalDataSourceImpl(this.storage);

  final PreferencesStorage storage;

  static const _homeDataCacheKey = 'home-model';

  @override
  HomeModelResponse getLocalData() {
    final localValue = storage.readString(key: _homeDataCacheKey);
    if (localValue != null) {
      final data = jsonDecode(localValue);
      return HomeModelResponse.fromJson(data as Map<String, dynamic>);
    } else {
      return const HomeModelResponse(allDoneHatims: 0, allDonePages: 0, donePages: 0);
    }
  }

  @override
  Future<void> saveLocalData(HomeModelResponse data) async {
    await storage.writeString(key: _homeDataCacheKey, value: jsonEncode(data.toJson()));
  }
}

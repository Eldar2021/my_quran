import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:mq_storage/mq_storage.dart';

@immutable
final class MqHomeLocalDataSourceImpl implements MqHomeLocalDataSource {
  const MqHomeLocalDataSourceImpl(this.storage);

  final PreferencesStorage storage;

  static const _homeDataCacheKey = 'home-model';

  @override
  MqHomeModel getLocalData() {
    final localValue = storage.readString(key: _homeDataCacheKey);
    if (localValue != null) {
      final data = jsonDecode(localValue);
      return MqHomeModel.fromJson(data as Map<String, dynamic>);
    } else {
      return const MqHomeModel(
        allDoneHatims: 0,
        allDonePages: 0,
        donePages: 0,
        enableCreationHatim: false,
        invitedHatims: [],
        hatims: [],
      );
    }
  }

  @override
  Future<void> saveLocalData(MqHomeModel data) async {
    await storage.writeString(
      key: _homeDataCacheKey,
      value: jsonEncode(data.toJson()),
    );
  }
}

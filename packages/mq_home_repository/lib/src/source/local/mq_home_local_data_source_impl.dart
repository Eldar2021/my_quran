import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:mq_storage/mq_storage.dart';

@immutable
final class MqHomeLocalDataSourceImpl implements MqHomeLocalDataSource {
  const MqHomeLocalDataSourceImpl(this.storage);

  final PreferencesStorage storage;

  static const _homeDataCacheKey = 'home-model';
  static const _homeBannersCacheKey = 'home-banners';

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

  @override
  List<MqHomeBannerResponse> getHomeBanners() {
    final localValue = storage.readString(key: _homeBannersCacheKey);
    if (localValue != null) {
      final data = jsonDecode(localValue) as List<dynamic>;
      return data
          .map(
            (e) => MqHomeBannerResponse.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> setHomeBanners(List<MqHomeBannerResponse> banners) async {
    await storage.writeString(
      key: _homeBannersCacheKey,
      value: jsonEncode(banners.map((e) => e.toJson()).toList()),
    );
  }
}

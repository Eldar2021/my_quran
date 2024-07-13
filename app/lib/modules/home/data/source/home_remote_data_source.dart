import 'package:flutter/material.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class HomeRemoteDataSource {
  const HomeRemoteDataSource(this.remoteClient);

  final MqDio remoteClient;

  Future<HomeModelResponse> getRemoteData() async {
    final remoteValue = await remoteClient.getType<HomeModelResponse>(
      apiConst.hatimDashBoard,
      fromJson: HomeModelResponse.fromJson,
    );

    return remoteValue.fold(
      (left) => throw Exception('Failed to fetch remote data $left'),
      (right) => right,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl(this.remoteClient);

  final MqRemoteClient remoteClient;

  @override
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

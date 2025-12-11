import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';

@immutable
final class MqHatimReadRepositoryImpl implements MqHatimRepository {
  const MqHatimReadRepositoryImpl({required this.dataSource});

  final MqHatimRemoteDataSource dataSource;

  @override
  Future<MqSearchModel> getSearch(String user) async {
    final res = await dataSource.getSearch(user);
    return res;
  }

  @override
  Future<MqHatimsModel> createHatim(MqHatimCreateModel hatim) async {
    final res = await dataSource.createHatim(hatim);
    return res;
  }
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';

@immutable
final class MqHatimReadRepositoryImpl implements MqHatimRepository {
  const MqHatimReadRepositoryImpl({required this.dataSource});

  final MqHatimRemoteDataSource dataSource;

  @override
  Future<MqSearchModel> searchParticipants(String value) async {
    return dataSource.searchParticipants(value);
  }

  @override
  Future<MqHatimModel> getHatimDataById(String id) {
    return dataSource.getHatimDataById(id);
  }

  @override
  Future<MqHatimModel> createHatim(MqHatimCreateModel param) async {
    return dataSource.createHatim(param);
  }

  @override
  Future<MqHatimModel> updateHatim(MqHatimUpdateModel param) {
    return dataSource.updateHatim(param);
  }

  @override
  Future<void> deleteHatim(String id) {
    return dataSource.deleteHatim(id);
  }
}

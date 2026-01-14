import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

@immutable
final class MqHatimRemoteDataSourceImpl implements MqHatimRemoteDataSource {
  const MqHatimRemoteDataSourceImpl(this.remoteClient);

  final MqRemoteClient remoteClient;

  @override
  Future<MqSearchModel> searchParticipants(String value) {
    try {
      return remoteClient.getType(
        '/api/v1/hatim/search_user/?q=$value',
        fromJson: MqSearchModel.fromJson,
      );
    } catch (e) {
      throw Exception('Error getSearch: $e');
    }
  }

  @override
  Future<MqHatimModel> getHatimDataById(String id) {
    try {
      return remoteClient.getType(
        '/api/v1/hatim/$id/',
        fromJson: MqHatimModel.fromJson,
      );
    } catch (e) {
      throw Exception('Error getSearch: $e');
    }
  }

  @override
  Future<MqHatimModel> createHatim(MqHatimCreateModel param) {
    try {
      return remoteClient.postType(
        '/api/v1/hatim/',
        fromJson: MqHatimModel.fromJson,
        body: {
          'title': param.title,
          'description': param.description,
          'type': param.type,
          'participants': param.participants,
        },
      );
    } catch (e) {
      throw Exception('Error createHatim: $e');
    }
  }

  @override
  Future<MqHatimModel> updateHatim(MqHatimUpdateModel param) {
    try {
      return remoteClient.patchType(
        '/api/v1/hatim/${param.id}/',
        fromJson: MqHatimModel.fromJson,
        body: {
          'title': param.data.title,
          'description': param.data.description,
          'type': param.data.type,
          'participants': param.data.participants,
        },
      );
    } catch (e) {
      throw Exception('Error updateHatim: $e');
    }
  }

  @override
  Future<void> deleteHatim(String id) async {
    try {
      await remoteClient.delete<void>(
        '/api/v1/hatim/$id/',
      );
    } catch (e) {
      throw Exception('Error deleteHatim: $e');
    }
  }
}

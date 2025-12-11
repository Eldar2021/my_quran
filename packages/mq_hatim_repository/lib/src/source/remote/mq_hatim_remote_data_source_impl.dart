import 'dart:async';

import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

final class MqHatimRemoteDataSourceImpl implements MqHatimRemoteDataSource {
  const MqHatimRemoteDataSourceImpl(this.remoteClient);

  final MqRemoteClient remoteClient;

  @override
  Future<MqSearchModel> getSearch(String? user) async {
    try {
      return remoteClient.getType(
        '/api/v1/hatim/search_user/?q=$user',
        fromJson: MqSearchModel.fromJson,
      );
    } catch (e) {
      throw Exception('Error getSearch: $e');
    }
  }

  @override
  Future<MqHatimsModel> createHatim(MqHatimCreateModel hatim) async {
    try {
      return remoteClient.postType(
        '/api/v1/hatim/',
        fromJson: MqHatimsModel.fromJson,
        body: {
          'title': hatim.title,
          'description': hatim.description,
          'type': hatim.type,
          'participants': hatim.participants,
        },
      );
    } catch (e) {
      throw Exception('Error createHatim: $e');
    }
  }
}

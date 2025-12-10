import 'dart:async';
import 'dart:convert';

import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

class MqHatimRemoteDataSourceImpl implements MqHatimRemoteDataSource {
  const MqHatimRemoteDataSourceImpl({required this.remoteClient});

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

  @override
  void connectToSocket(String token) {
    HatimWebSocketClient.instance.connect(token);
  }

  @override
  void sinkHatimJuzs(String hatimId) {
    final data = {
      'type': 'list_of_juz',
      'hatim_id': hatimId,
    };
    HatimWebSocketClient.instance.send(json.encode(data));
  }

  @override
  void sinkHatimUserPages() {
    final data = {'type': 'user_pages'};
    HatimWebSocketClient.instance.send(jsonEncode(data));
  }

  @override
  void sinkHatimJuzPages(String juzId) {
    final data = {
      'type': 'list_of_page',
      'juz_id': juzId,
    };
    HatimWebSocketClient.instance.send(jsonEncode(data));
  }

  @override
  void sinkSelectPage(String pageId) {
    final data = {
      'type': 'book',
      'pageId': pageId,
    };
    HatimWebSocketClient.instance.send(jsonEncode(data));
  }

  @override
  void sinkUnSelectPage(String pageId) {
    final data = {
      'type': 'to_do',
      'pageId': pageId,
    };
    HatimWebSocketClient.instance.send(jsonEncode(data));
  }

  @override
  void sinkInProgressPages(List<String> pageIds) {
    final data = {
      'type': 'in_progress',
      'pageIds': pageIds,
    };
    HatimWebSocketClient.instance.send(jsonEncode(data));
  }

  @override
  void sinkDonePages(List<String> pageIds) {
    final data = {
      'type': 'done',
      'pageIds': pageIds,
    };
    HatimWebSocketClient.instance.send(jsonEncode(data));
  }

  @override
  Future<void> disconnect() async {
    HatimWebSocketClient.instance.disconnect();
  }

  @override
  Future<void> close() async {
    HatimWebSocketClient.instance.disconnect();
  }

  @override
  Stream<dynamic> get stream {
    return HatimWebSocketClient.instance.messages;
  }

  @override
  Stream<ConnectionState> get connectionStream {
    return HatimWebSocketClient.instance.connection;
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

class MqHatimRemoteDataSourceImpl implements MqHatimRemoteDataSource {
  MqHatimRemoteDataSourceImpl({required this.remoteClient});

  final MqRemoteClient remoteClient;

  late final WebSocketChannel channel;
  bool isInitilized = false;

  @override
  Future<MqSearchModel> getSearch(String? user) async {
    try {
      return remoteClient.getType('/api/v1/hatim/search_user/?q=$user', fromJson: MqSearchModel.fromJson);
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
    if (!isInitilized) {
      channel = WebSocketChannel.connect(Uri.parse('wss://myquran.life/ws/?token=$token'));
      isInitilized = true;
    }
  }

  @override
  void sinkHatimJuzs(String hatimId) {
    final data = {'type': 'list_of_juz', 'hatim_id': hatimId};
    channel.sink.add(json.encode(data));
  }

  @override
  void sinkHatimUserPages() {
    final data = {'type': 'user_pages'};
    channel.sink.add(jsonEncode(data));
  }

  @override
  void sinkHatimJuzPages(String juzId) {
    final data = {'type': 'list_of_page', 'juz_id': juzId};
    channel.sink.add(jsonEncode(data));
  }

  @override
  void sinkSelectPage(String pageId) {
    final data = {'type': 'book', 'pageId': pageId};
    channel.sink.add(jsonEncode(data));
  }

  @override
  void sinkUnSelectPage(String pageId) {
    final data = {'type': 'to_do', 'pageId': pageId};
    channel.sink.add(jsonEncode(data));
  }

  @override
  void sinkInProgressPages(List<String> pageIds) {
    final data = {'type': 'in_progress', 'pageIds': pageIds};
    channel.sink.add(jsonEncode(data));
  }

  @override
  void sinkDonePages(List<String> pageIds) {
    final data = {'type': 'done', 'pageIds': pageIds};
    channel.sink.add(jsonEncode(data));
  }

  @override
  Future<void> close() async {
    await channel.sink.close();
  }

  @override
  Stream<dynamic> get stream => channel.stream;
}

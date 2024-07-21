import 'dart:async';
import 'dart:convert';

import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HatimRemoteDataSourceImpl implements HatimRemoteDataSource {
  HatimRemoteDataSourceImpl({
    required this.remoteClient,
  });

  final MqDio remoteClient;

  late final WebSocketChannel channel;
  bool isInitilized = false;

  @override
  Future<HatimReadModel> getHatim() async {
    try {
      final res = await remoteClient.postType(
        apiConst.joinToHatim,
        fromJson: HatimReadModel.fromJson,
      );

      return res.fold((l) => throw l, (r) => r);
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      throw Exception(e);
    }
  }

  @override
  void connectToSocket(String token) {
    if (!isInitilized) {
      channel = WebSocketChannel.connect(
        Uri.parse(apiConst.getSocket(token)),
      );
      isInitilized = true;
    }
  }

  @override
  void sinkHatimJuzs(String hatimId) {
    final data = {
      'type': 'list_of_juz',
      'hatim_id': hatimId,
    };
    channel.sink.add(json.encode(data));
  }

  @override
  void sinkHatimUserPages() {
    final data = {
      'type': 'user_pages',
    };
    channel.sink.add(jsonEncode(data));
  }

  @override
  void sinkHatimJuzPages(String juzId) {
    final data = {
      'type': 'list_of_page',
      'juz_id': juzId,
    };
    channel.sink.add(jsonEncode(data));
  }

  @override
  void sinkSelectPage(String pageId) {
    final data = {
      'type': 'book',
      'pageId': pageId,
    };
    channel.sink.add(jsonEncode(data));
  }

  @override
  void sinkUnSelectPage(String pageId) {
    final data = {
      'type': 'to_do',
      'pageId': pageId,
    };
    channel.sink.add(jsonEncode(data));
  }

  @override
  void sinkInProgressPages(List<String> pageIds) {
    final data = {
      'type': 'in_progress',
      'pageIds': pageIds,
    };
    channel.sink.add(jsonEncode(data));
  }

  @override
  void sinkDonePages(List<String> pageIds) {
    final data = {
      'type': 'done',
      'pageIds': pageIds,
    };
    channel.sink.add(jsonEncode(data));
  }

  @override
  Future<void> close() async {
    await channel.sink.close();
  }

  @override
  Stream<dynamic> get stream => channel.stream;
}

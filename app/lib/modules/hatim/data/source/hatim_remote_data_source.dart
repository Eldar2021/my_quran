import 'dart:async';
import 'dart:convert';

import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HatimRemoteDataSource {
  HatimRemoteDataSource({
    required this.remoteClient,
  });

  final RemoteClient remoteClient;

  late final WebSocketChannel channel;
  bool isInitilized = false;

  Future<HatimReadModel> getHatim(String token) async {
    try {
      final res = await remoteClient.post(
        apiConst.joinToHatim,
        fromJson: HatimReadModel.fromJson,
        token: token,
      );

      return res.fold((l) => throw l, (r) => r);
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      throw Exception(e);
    }
  }

  void connectToSocket(String token) {
    if (!isInitilized) {
      channel = WebSocketChannel.connect(
        Uri.parse(apiConst.getSocket(token)),
      );
      isInitilized = true;
    }
  }

  void sinkHatimJuzs(String hatimId) {
    final data = {
      'type': 'list_of_juz',
      'hatim_id': hatimId,
    };
    channel.sink.add(json.encode(data));
  }

  void sinkHatimUserPages() {
    final data = {
      'type': 'user_pages',
    };
    channel.sink.add(jsonEncode(data));
  }

  void sinkHatimJuzPages(String juzId) {
    final data = {
      'type': 'list_of_page',
      'juz_id': juzId,
    };
    channel.sink.add(jsonEncode(data));
  }

  void sinkSelectPage(String pageId) {
    final data = {
      'type': 'book',
      'pageId': pageId,
    };
    channel.sink.add(jsonEncode(data));
  }

  void sinkUnSelectPage(String pageId) {
    final data = {
      'type': 'to_do',
      'pageId': pageId,
    };
    channel.sink.add(jsonEncode(data));
  }

  void sinkInProgressPages(List<String> pageIds) {
    final data = {
      'type': 'in_progress',
      'pageIds': pageIds,
    };
    channel.sink.add(jsonEncode(data));
  }

  void sinkDonePages(List<String> pageIds) {
    final data = {
      'type': 'done',
      'pageIds': pageIds,
    };
    channel.sink.add(jsonEncode(data));
  }

  Future<void> close() async {
    await channel.sink.close();
  }

  Stream<dynamic> get stream => channel.stream;
}

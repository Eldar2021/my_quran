import 'dart:convert';
import 'dart:developer';

import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:web_socket_client/web_socket_client.dart';

class MqHatimSocketImpl implements MqHatimSocket {
  MqHatimSocketImpl();

  late final WebSocket channel;

  bool isInitilized = false;

  @override
  void connectToSocket(String token, String hatimId) {
    if (!isInitilized) {
      channel = WebSocket(
        Uri.parse('wss://myquran.life/ws/?token=$token'),
        backoff: BinaryExponentialBackoff(
          initial: const Duration(seconds: 1),
          maximumStep: 30,
        ),
      );

      channel.connection.listen((state) {
        log('Socket state: $state');
        if (state is Connected) sinkHatimJuzs(hatimId);
      });
      isInitilized = true;
    }
  }

  @override
  void sinkHatimJuzs(String hatimId) {
    final data = {
      'type': 'list_of_juz',
      'hatim_id': hatimId,
    };
    log('sinkHatimJuzs: ${json.encode(data)}');
    channel.send(json.encode(data));
  }

  @override
  void sinkHatimUserPages() {
    final data = {'type': 'user_pages'};
    channel.send(jsonEncode(data));
  }

  @override
  void sinkHatimJuzPages(String juzId) {
    final data = {
      'type': 'list_of_page',
      'juz_id': juzId,
    };
    channel.send(jsonEncode(data));
  }

  @override
  void sinkSelectPage(String pageId) {
    final data = {
      'type': 'book',
      'pageId': pageId,
    };
    channel.send(jsonEncode(data));
  }

  @override
  void sinkUnSelectPage(String pageId) {
    final data = {
      'type': 'to_do',
      'pageId': pageId,
    };
    channel.send(jsonEncode(data));
  }

  @override
  void sinkInProgressPages(List<String> pageIds) {
    final data = {
      'type': 'in_progress',
      'pageIds': pageIds,
    };
    channel.send(jsonEncode(data));
  }

  @override
  void sinkDonePages(List<String> pageIds) {
    final data = {
      'type': 'done',
      'pageIds': pageIds,
    };
    channel.send(jsonEncode(data));
  }

  @override
  void close() => channel.close();

  @override
  Stream<(HatimResponseType, List<MqHatimBaseEntity>)> get stream {
    return channel.messages.map((data) {
      log('stream: $data');
      final src = HatimBaseResponse.fromJson(
        jsonDecode(data as String) as Map<String, dynamic>,
      );

      return switch (src.type) {
        HatimResponseType.listOfJuz => _receidevJuzs(src.data as List<dynamic>),
        HatimResponseType.listOfPage => _receidevJuzPage(
          src.data as List<dynamic>,
        ),
        HatimResponseType.userPages => _receidevUserPages(
          src.data as List<dynamic>,
        ),
      };
    });
  }

  (HatimResponseType, List<MqHatimJusEntity>) _receidevJuzs(List<dynamic> src) {
    final data = src.map((e) => HatimJus.fromJson(e as Map<String, dynamic>)).toList();
    return (HatimResponseType.listOfJuz, data.map((e) => e.entity).toList());
  }

  (HatimResponseType, List<MqHatimPagesEntity>) _receidevJuzPage(
    List<dynamic> src,
  ) {
    final data = src.map((e) => HatimPages.fromJson(e as Map<String, dynamic>)).toList();
    return (HatimResponseType.listOfPage, data.map((e) => e.entity).toList());
  }

  (HatimResponseType, List<MqHatimPagesEntity>) _receidevUserPages(
    List<dynamic> src,
  ) {
    final data = src.map((e) => HatimPages.fromJson(e as Map<String, dynamic>)).toList();
    return (HatimResponseType.userPages, data.map((e) => e.entity).toList());
  }
}

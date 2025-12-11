import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:web_socket_client/web_socket_client.dart';

class MqHatimSocketImpl implements MqHatimSocket {
  MqHatimSocketImpl();

  late final WebSocket channel;

  StreamSubscription<ConnectionState>? _connectionSubscription;

  bool isInitialized = false;

  @override
  void connectToSocket(String token, String hatimId) {
    if (!isInitialized) {
      channel = WebSocket(
        Uri.parse('wss://myquran.life/ws/?token=$token'),
        backoff: BinaryExponentialBackoff(
          initial: const Duration(seconds: 1),
          maximumStep: 30,
        ),
      );

      _connectionSubscription = channel.connection.listen((state) {
        log('Socket state: $state');
        if (state is Connected) sinkHatimJuzs(hatimId);
      });

      isInitialized = true;
    }
  }

  @override
  void sinkHatimJuzs(String hatimId) {
    final data = {
      'type': 'list_of_juz',
      'hatim_id': hatimId,
    };
    log('sinkHatimJuzs: ${jsonEncode(data)}');
    channel.send(jsonEncode(data));
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
  void close() {
    _connectionSubscription?.cancel();
    channel.close();
  }

  @override
  Stream<(HatimResponseType, List<MqHatimBaseEntity>)> get stream {
    return channel.messages.map((data) {
      log('stream: $data');
      final src = HatimBaseResponse.fromJson(
        jsonDecode(data as String) as Map<String, dynamic>,
      );

      return switch (src.type) {
        HatimResponseType.listOfJuz => _receiveJuzs(src.data as List<dynamic>),
        HatimResponseType.listOfPage => _receiveJuzPage(src.data as List<dynamic>),
        HatimResponseType.userPages => _receiveUserPages(src.data as List<dynamic>),
      };
    });
  }

  (HatimResponseType, List<MqHatimJusEntity>) _receiveJuzs(List<dynamic> src) {
    final data = src.map((e) => HatimJus.fromJson(e as Map<String, dynamic>)).toList();
    return (HatimResponseType.listOfJuz, data.map((e) => e.entity).toList());
  }

  (HatimResponseType, List<MqHatimPagesEntity>) _receiveJuzPage(List<dynamic> src) {
    final data = src.map((e) => HatimPages.fromJson(e as Map<String, dynamic>)).toList();
    return (HatimResponseType.listOfPage, data.map((e) => e.entity).toList());
  }

  (HatimResponseType, List<MqHatimPagesEntity>) _receiveUserPages(List<dynamic> src) {
    final data = src.map((e) => HatimPages.fromJson(e as Map<String, dynamic>)).toList();
    return (HatimResponseType.userPages, data.map((e) => e.entity).toList());
  }
}

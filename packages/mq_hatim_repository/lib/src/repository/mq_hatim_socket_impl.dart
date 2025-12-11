import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:mq_hatim_repository/mq_hatim_repository.dart';

class MqHatimSocketImpl implements MqHatimSocket {
  MqHatimSocketImpl();

  late final WebSocket channel;
  bool isInitialized = false;

  @override
  void connectToSocket(String token) {
    if (!isInitialized) {
      channel = WebSocket(
        Uri.parse('wss://myquran.life/ws/?token=$token'),
        backoff: BinaryExponentialBackoff(
          initial: const Duration(seconds: 1),
          maximumStep: 30,
        ),
      );
      isInitialized = true;
    }
  }

  @override
  Stream<ConnectionState> get connectionStream => channel.connection;

  @override
  Stream<dynamic> get messages => channel.messages;

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
  void close() => channel.close();
}

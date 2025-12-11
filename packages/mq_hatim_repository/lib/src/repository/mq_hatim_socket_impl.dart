import 'dart:convert';

import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MqHatimSocketImpl implements MqHatimSocket {
  MqHatimSocketImpl();

  late final WebSocketChannel channel;
  bool isInitilized = false;

  @override
  void connectToSocket(String token) {
    if (!isInitilized) {
      channel = WebSocketChannel.connect(
        Uri.parse('wss://myquran.life/ws/?token=$token'),
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
    final data = {'type': 'user_pages'};
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
  Stream<(HatimResponseType, List<MqHatimBaseEntity>)> get stream {
    return channel.stream.map((data) {
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

import 'dart:async';
import 'dart:convert';

import 'package:mq_hatim_repository/mq_hatim_repository.dart';

class MqHatimSocketMock implements MqHatimSocket {
  MqHatimSocketMock();

  final StreamController<dynamic> _controller = StreamController<dynamic>();

  @override
  void connectToSocket(String token) {}

  @override
  void sinkHatimJuzs(String hatimId) {
    final data = {'type': 'list_of_juz', 'hatim_id': hatimId};
    _controller.add(json.encode(data));
  }

  @override
  void sinkHatimUserPages() {
    final data = {'type': 'user_pages'};
    _controller.add(jsonEncode(data));
  }

  @override
  void sinkHatimJuzPages(String juzId) {
    final data = {'type': 'list_of_page', 'juz_id': juzId};
    _controller.add(jsonEncode(data));
  }

  @override
  void sinkSelectPage(String pageId) {
    final data = {'type': 'book', 'pageId': pageId};
    _controller.add(jsonEncode(data));
  }

  @override
  void sinkUnSelectPage(String pageId) {
    final data = {'type': 'to_do', 'pageId': pageId};
    _controller.add(jsonEncode(data));
  }

  @override
  void sinkInProgressPages(List<String> pageIds) {
    final data = {'type': 'in_progress', 'pageIds': pageIds};
    _controller.add(jsonEncode(data));
  }

  @override
  void sinkDonePages(List<String> pageIds) {
    final data = {'type': 'done', 'pageIds': pageIds};
    _controller.add(jsonEncode(data));
  }

  @override
  void close() => _controller.close();

  @override
  Stream<(HatimResponseType, List<MqHatimBaseEntity>)> get stream {
    return _controller.stream.map((data) {
      final src = HatimBaseResponse.fromJson(
        jsonDecode(data as String) as Map<String, dynamic>,
      );

      return switch (src.type) {
        HatimResponseType.listOfJuz => _receidevJuzs(
          src.data as List<dynamic>,
        ),
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

  @override
  Stream<ConnectionState> get connectionStream {
    return Stream<ConnectionState>.fromIterable([
      const Connecting(),
      const Connected(),
    ]);
  }
}

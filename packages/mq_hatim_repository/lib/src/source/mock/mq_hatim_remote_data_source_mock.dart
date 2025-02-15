import 'dart:async';
import 'dart:convert';

import 'package:mq_hatim_repository/mq_hatim_repository.dart';

class MqHatimRemoteDataSourceMock implements MqHatimRemoteDataSource {
  final StreamController<dynamic> _controller = StreamController<dynamic>();

  @override
  Future<HatimReadModel> getHatim() async {
    return const HatimReadModel(id: '1', status: 'done', type: 'user_pages');
  }

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
  Future<void> close() async {
    await _controller.close();
  }

  @override
  Stream<dynamic> get stream => _controller.stream;
}

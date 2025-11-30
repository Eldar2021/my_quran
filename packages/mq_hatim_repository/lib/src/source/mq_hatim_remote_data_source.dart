import 'package:mq_hatim_repository/mq_hatim_repository.dart';

abstract class MqHatimRemoteDataSource {
  Future<MqSearchModel> getSearch(String? user);

  Future<MqHatimsModel> createHatim(
    MqHatimCreateModel hatim,
  );

  void connectToSocket(String token);

  void sinkHatimJuzs(String hatimId);

  void sinkHatimUserPages();

  void sinkHatimJuzPages(String juzId);

  void sinkSelectPage(String pageId);

  void sinkUnSelectPage(String pageId);

  void sinkInProgressPages(List<String> pageIds);

  void sinkDonePages(List<String> pageIds);

  Future<void> close();

  Stream<dynamic> get stream;
}

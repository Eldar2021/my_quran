import 'package:mq_hatim_repository/mq_hatim_repository.dart';

abstract interface class MqHatimSocket {
  void connectToSocket(String token);

  Stream<dynamic> get messages;

  Stream<ConnectionState> get connectionStream;

  void sinkHatimJuzs(String hatimId);

  void sinkHatimUserPages();

  void sinkHatimJuzPages(String juzId);

  void sinkSelectPage(String pageId);

  void sinkUnSelectPage(String pageId);

  void sinkInProgressPages(List<String> pageIds);

  void sinkDonePages(List<String> pageIds);

  void close();
}

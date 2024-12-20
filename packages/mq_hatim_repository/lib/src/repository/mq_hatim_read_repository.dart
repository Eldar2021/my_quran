import 'package:mq_hatim_repository/mq_hatim_repository.dart';

abstract class MqHatimRepository {
  Future<MqHatimReadEntity> getHatim();

  void connectToSocket(String token);

  void sinkHatimJuzs(String hatimId);

  void sinkHatimUserPages();

  void sinkHatimJuzPages(String juzId);

  void sinkSelectPage(String pageId);

  void sinkUnSelectPage(String pageId);

  void sinkInProgressPages(List<String> pageIds);

  void sinkDonePages(List<String> pageIds);

  Stream<(HatimResponseType, List<MqHatimBaseEntity>)> get stream;

  Future<void> close();
}

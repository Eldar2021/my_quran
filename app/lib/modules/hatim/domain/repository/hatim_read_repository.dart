import 'package:my_quran/modules/modules.dart';

abstract class HatimRepository {
  Future<HatimReadEntity> getHatim(String token);

  void connectToSocket(String token);

  void sinkHatimJuzs(String hatimId);

  void sinkHatimUserPages();

  void sinkHatimJuzPages(String juzId);

  void sinkSelectPage(String pageId);

  void sinkUnSelectPage(String pageId);

  void sinkInProgressPages(List<String> pageIds);

  void sinkDonePages(List<String> pageIds);

  Stream<(HatimResponseType, List<HatimBaseEntity>)> get stream;

  Future<void> close();
}

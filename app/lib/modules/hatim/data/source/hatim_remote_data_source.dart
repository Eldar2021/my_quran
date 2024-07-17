import 'package:my_quran/modules/modules.dart';

abstract class HatimRemoteDataSource {
  Future<HatimReadModel> getHatim();
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

import 'package:my_quran/modules/modules.dart';

abstract class HomeLocalDataSource {
  HomeModelResponse getLocalData();

  Future<void> saveLocalData(HomeModelResponse data);
}

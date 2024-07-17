import 'package:my_quran/modules/modules.dart';

abstract class HomeRemoteDataSource {
  Future<HomeModelResponse> getRemoteData();
}

import 'package:my_quran/modules/modules.dart';

class MockHomeRemoteDataSource implements HomeRemoteDataSource {
  @override
  Future<HomeModelResponse> getRemoteData() async {
    return const HomeModelResponse(
      allDoneHatims: 100,
      allDonePages: 10000,
      donePages: 10,
    );
  }
}

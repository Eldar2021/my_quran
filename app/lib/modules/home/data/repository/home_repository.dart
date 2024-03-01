import 'package:my_quran/modules/modules.dart';

class HomeRepositoryImpl {
  const HomeRepositoryImpl(
    this.localDataSource,
    this.remoteDataSource,
  );

  final HomeLocalDataSource localDataSource;
  final HomeRemoteDataSource remoteDataSource;

  Future<HomeModel> getData(String token) async {
    try {
      final remoteData = await remoteDataSource.getRemoteData(token);
      await localDataSource.saveLocalData(remoteData);
      return remoteData;
    } catch (e) {
      try {
        final localData = await localDataSource.getLocalData();
        return localData;
      } catch (e) {
        return const HomeModel(
          allDoneHatims: 0,
          allDonePages: 0,
          donePages: 0,
        );
      }
    }
  }
}

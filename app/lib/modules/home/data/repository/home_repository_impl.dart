import 'dart:developer';

import 'package:my_quran/modules/modules.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(
    this.localDataSource,
    this.remoteDataSource,
  );

  final HomeLocalDataSource localDataSource;
  final HomeRemoteDataSource remoteDataSource;

  @override
  Future<HomeEntity> getData(String token) async {
    try {
      final remoteData = await remoteDataSource.getRemoteData(token);
      await localDataSource.saveLocalData(remoteData);
      return _convertData(remoteData);
    } catch (e) {
      log('HomeRepositoryImpl, getData error: $e');
      return _convertData(localDataSource.getLocalData());
    }
  }

  HomeEntity _convertData(HomeModelResponse response) {
    return HomeEntity(
      allDoneHatims: response.allDoneHatims,
      allDonePages: response.allDonePages,
      donePages: response.donePages,
    );
  }
}

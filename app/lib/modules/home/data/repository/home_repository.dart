import 'dart:developer';

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
      log('HomeRepositoryImpl, getData error: $e');
      return localDataSource.getLocalData();
    }
  }
}

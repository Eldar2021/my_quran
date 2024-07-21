import 'package:flutter/material.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class HomeLocalDataSourceMock implements HomeLocalDataSource {
  const HomeLocalDataSourceMock();

  @override
  HomeModelResponse getLocalData() {
    return const HomeModelResponse(allDoneHatims: 0, allDonePages: 0, donePages: 0);
  }

  @override
  Future<void> saveLocalData(HomeModelResponse data) => Future.value();
}

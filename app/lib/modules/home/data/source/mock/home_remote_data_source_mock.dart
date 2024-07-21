import 'package:flutter/material.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class HomeRemoteDataSourceMock implements HomeRemoteDataSource {
  const HomeRemoteDataSourceMock();

  @override
  Future<HomeModelResponse> getRemoteData() async {
    return const HomeModelResponse(
      allDoneHatims: 0,
      allDonePages: 0,
      donePages: 0,
    );
  }
}

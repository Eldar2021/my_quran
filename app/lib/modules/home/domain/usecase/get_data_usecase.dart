import 'package:flutter/material.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class GetHomeDataUseCase {
  const GetHomeDataUseCase(this.repository);

  final HomeRepository repository;

  Future<HomeEntity> execute(String token) {
    return repository.getData(token);
  }
}

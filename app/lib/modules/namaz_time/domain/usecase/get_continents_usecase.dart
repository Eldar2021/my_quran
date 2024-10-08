import 'package:flutter/material.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class GetContinentsUseCase {
  const GetContinentsUseCase(this.repository);

  final NamazTimesRepository repository;

  Future<ContinentsEntity> execute() {
    return repository.getContinents();
  }
}

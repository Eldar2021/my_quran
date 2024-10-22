import 'package:flutter/material.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class GetNamazTimesUseCase {
  const GetNamazTimesUseCase(this.repository);

  final NamazTimesRepository repository;

  Future<NamazTimesEntity> execute(int placeId) {
    return repository.getNamazTimes(placeId);
  }
}

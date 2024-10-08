import 'package:flutter/material.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class GetRegionsUseCase {
  const GetRegionsUseCase(this.repository);

  final NamazTimesRepository repository;

  Future<RegionsEntity> execute(int continentId) {
    return repository.getRegions(continentId);
  }
}

import 'package:flutter/material.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:mq_storage/mq_storage.dart';

@immutable
final class MqQuranLocalDataSourceImpl implements MqQuranLocalDataSource {
  const MqQuranLocalDataSourceImpl(this.storage);

  final PreferencesStorage storage;

  @override
  List<JuzModelResponse> getJuzsData() {
    final surahs = mqQuranJuzsData
        .map(
          JuzModelResponse.fromJson,
        )
        .toList();
    return surahs;
  }

  @override
  List<SurahModelResponse> getSurahsData() {
    final surahs = mqQuranSurahsData
        .map(
          SurahModelResponse.fromJson,
        )
        .toList();
    return surahs;
  }
}

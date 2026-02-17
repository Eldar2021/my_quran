import 'package:flutter/material.dart';
import 'package:mq_quran_client/mq_quran_client.dart';

@immutable
final class QuranStaticRepositoryImpl implements QuranStaticRepository {
  const QuranStaticRepositoryImpl();

  @override
  List<QuranJuzModel> getJuzsData() {
    return mqQuranJuzsData.map(QuranJuzModel.fromJson).toList();
  }

  @override
  List<QuranSurahModel> getSurahsData() {
    return mqQuranSurahsData.map(QuranSurahModel.fromJson).toList();
  }
}

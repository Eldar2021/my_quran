import 'package:flutter/material.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

@immutable
final class QuranDataEntity {
  const QuranDataEntity({
    required this.verses,
    required this.meta,
  });

  final List<QuranDataVerseEntity> verses;
  final QuranDataMetaEntity meta;
}

@immutable
final class QuranDataMetaEntity {
  const QuranDataMetaEntity({
    required this.filters,
  });

  final QuranDataFilterEntity filters;
}

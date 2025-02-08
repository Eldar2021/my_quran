import 'package:flutter/material.dart';

sealed class QuranDataFilterEntity {
  const QuranDataFilterEntity({
    required this.value,
  });

  final String value;
}

@immutable
final class QuranDataFilterPageNumberEntity extends QuranDataFilterEntity {
  const QuranDataFilterPageNumberEntity({
    required this.pageNumber,
  }) : super(value: pageNumber);

  final String pageNumber;
}

@immutable
final class QuranDataFilterJuzNumberEntity extends QuranDataFilterEntity {
  const QuranDataFilterJuzNumberEntity({
    required this.juzNumber,
  }) : super(value: juzNumber);

  final String juzNumber;
}

@immutable
final class QuranDataFilterSurahNumberEntity extends QuranDataFilterEntity {
  const QuranDataFilterSurahNumberEntity({
    required this.surahNumber,
  }) : super(value: surahNumber);

  final String surahNumber;
}

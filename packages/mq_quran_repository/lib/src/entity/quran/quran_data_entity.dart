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

  StringBuffer get samePage {
    return StringBuffer()
      ..writeAll(
        verses.map(
          (e) {
            final a = e.text.replaceAll('\u{06DF}', '\u{0652}');
            final sajdaSymbol = e.hasSajda ? MqQuranStatic.sajdaSymbol : '';
            return '$a $sajdaSymbol\uFD3F${e.ayatNumber.toArabicDigits}\uFD3E  ';
          },
        ),
      );
  }
}

@immutable
final class QuranDataMetaEntity {
  const QuranDataMetaEntity({
    required this.filters,
  });

  final QuranDataFilterEntity filters;
}

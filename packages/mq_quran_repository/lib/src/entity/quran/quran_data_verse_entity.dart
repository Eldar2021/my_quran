import 'package:flutter/material.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

sealed class QuranDataVerseEntity {
  const QuranDataVerseEntity({
    required this.id,
    required this.verseKey,
    required this.text,
  });

  final int id;
  final String verseKey;
  final String text;

  int get juzNumber => int.parse(verseKey.split(':').first);
  int get ayatNumber => int.parse(verseKey.split(':').last);
  bool get isFirst => ayatNumber == 1;
  bool get hasSajda => MqQuranStatic.sajdaAyats.contains(id);
}

@immutable
final class QuranDataVerseUthmaniSimpleEntity extends QuranDataVerseEntity {
  const QuranDataVerseUthmaniSimpleEntity({
    required super.id,
    required super.verseKey,
    required this.textUtmaniSimple,
  }) : super(text: textUtmaniSimple);

  final String textUtmaniSimple;
}

@immutable
final class QuranDataVerseImlaeiEntity extends QuranDataVerseEntity {
  const QuranDataVerseImlaeiEntity({
    required super.id,
    required super.verseKey,
    required this.textImlaei,
  }) : super(text: textImlaei);

  final String textImlaei;
}

@immutable
final class QuranDataVerseUthmaniEntity extends QuranDataVerseEntity {
  const QuranDataVerseUthmaniEntity({
    required super.id,
    required super.verseKey,
    required this.textUtmani,
  }) : super(text: textUtmani);

  final String textUtmani;
}

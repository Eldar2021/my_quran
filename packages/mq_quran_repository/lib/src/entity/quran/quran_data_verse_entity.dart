import 'package:flutter/material.dart';

sealed class QuranDataVerseEntity {
  const QuranDataVerseEntity({
    required this.id,
    required this.verseKey,
    required this.text,
  });

  final int id;
  final String verseKey;
  final String text;
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

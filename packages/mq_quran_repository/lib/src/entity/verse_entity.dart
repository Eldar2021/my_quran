import 'package:flutter/material.dart';

const sajdaAyats = [
  1160,
  1722,
  1951,
  2138,
  2308,
  2613,
  2672,
  2915,
  3185,
  3518,
  3994,
  4256,
  4846,
  5905,
  6125,
];

@immutable
final class VerseEnity {
  const VerseEnity({
    required this.id,
    required this.verseKey,
    required this.textUthmani,
  });

  final int id;
  final String verseKey;
  final String textUthmani;

  int get juzNumber => int.parse(verseKey.split(':').first);
  int get ayatNumber => int.parse(verseKey.split(':').last);
  bool get isFirst => ayatNumber == 1;
  bool get hasSajda => sajdaAyats.contains(id);
}

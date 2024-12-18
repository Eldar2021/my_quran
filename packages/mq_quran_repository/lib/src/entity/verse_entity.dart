import 'package:flutter/material.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

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
  bool get hasSajda => MqQuranStatic.sajdaAyats.contains(id);
}

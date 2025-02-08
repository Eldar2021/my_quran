import 'package:flutter/foundation.dart';

@immutable
final class MqJuzEntity {
  const MqJuzEntity({
    required this.id,
    required this.juzNumber,
    required this.firstVerseId,
    required this.lastVerseId,
    required this.versesCount,
    required this.verseMapping,
  });

  final int id;
  final int juzNumber;
  final int firstVerseId;
  final int lastVerseId;
  final int versesCount;
  final Map<String, String> verseMapping;
}

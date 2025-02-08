import 'package:flutter/foundation.dart';

@immutable
final class MqJuzEntity {
  const MqJuzEntity({
    this.id,
    this.juzNumber,
    this.firstVerseId,
    this.lastVerseId,
    this.versesCount,
    this.verseMapping,
  });

  final int? id;
  final int? juzNumber;
  final int? firstVerseId;
  final int? lastVerseId;
  final int? versesCount;
  final Map<String, String>? verseMapping;
}

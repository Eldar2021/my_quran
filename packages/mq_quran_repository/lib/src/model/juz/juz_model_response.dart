import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

part 'juz_model_response.g.dart';

@JsonSerializable()
@immutable
final class JuzModelResponse {
  const JuzModelResponse({
    this.id,
    this.juzNumber,
    this.firstVerseId,
    this.lastVerseId,
    this.versesCount,
    this.verseMapping,
  });

  factory JuzModelResponse.fromJson(Map<String, dynamic> json) => _$JuzModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$JuzModelResponseToJson(this);

  final int? id;
  final int? juzNumber;
  final int? firstVerseId;
  final int? lastVerseId;
  final int? versesCount;
  final Map<String, String>? verseMapping;

  MqJuzEntity toEntity() {
    return MqJuzEntity(
      id: id,
      juzNumber: juzNumber,
      firstVerseId: firstVerseId,
      lastVerseId: lastVerseId,
      versesCount: versesCount,
      verseMapping: verseMapping,
    );
  }
}

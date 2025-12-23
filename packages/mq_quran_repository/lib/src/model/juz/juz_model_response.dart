import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

part 'juz_model_response.g.dart';

@JsonSerializable()
@immutable
final class JuzModelResponse {
  const JuzModelResponse({
    required this.id,
    required this.juzNumber,
    required this.firstVerseId,
    required this.lastVerseId,
    required this.versesCount,
    required this.verseMapping,
  });

  factory JuzModelResponse.fromJson(Map<String, dynamic> json) =>
      _$JuzModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$JuzModelResponseToJson(this);

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'juz_number')
  final int juzNumber;
  @JsonKey(name: 'first_verse_id')
  final int firstVerseId;
  @JsonKey(name: 'last_verse_id')
  final int lastVerseId;
  @JsonKey(name: 'verses_count')
  final int versesCount;
  @JsonKey(name: 'verse_mapping')
  final Map<String, String> verseMapping;

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

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

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
}

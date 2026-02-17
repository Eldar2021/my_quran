import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quran_juz_model.g.dart';

@JsonSerializable()
@immutable
final class QuranJuzModel extends Equatable {
  const QuranJuzModel({
    required this.id,
    required this.juzNumber,
    required this.firstVerseId,
    required this.lastVerseId,
    required this.versesCount,
    required this.verseMapping,
  });

  factory QuranJuzModel.fromJson(Map<String, dynamic> json) => _$QuranJuzModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuranJuzModelToJson(this);

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

  @override
  List<Object?> get props => [
    id,
    juzNumber,
    firstVerseId,
    lastVerseId,
    versesCount,
    verseMapping,
  ];
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'juz_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JuzModelResponse _$JuzModelResponseFromJson(Map<String, dynamic> json) => JuzModelResponse(
  id: (json['id'] as num).toInt(),
  juzNumber: (json['juz_number'] as num).toInt(),
  firstVerseId: (json['first_verse_id'] as num).toInt(),
  lastVerseId: (json['last_verse_id'] as num).toInt(),
  versesCount: (json['verses_count'] as num).toInt(),
  verseMapping: Map<String, String>.from(json['verse_mapping'] as Map),
);

Map<String, dynamic> _$JuzModelResponseToJson(JuzModelResponse instance) => <String, dynamic>{
  'id': instance.id,
  'juz_number': instance.juzNumber,
  'first_verse_id': instance.firstVerseId,
  'last_verse_id': instance.lastVerseId,
  'verses_count': instance.versesCount,
  'verse_mapping': instance.verseMapping,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'juz_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JuzModelResponse _$JuzModelResponseFromJson(Map<String, dynamic> json) => JuzModelResponse(
      id: (json['id'] as num?)?.toInt(),
      juzNumber: (json['juzNumber'] as num?)?.toInt(),
      firstVerseId: (json['firstVerseId'] as num?)?.toInt(),
      lastVerseId: (json['lastVerseId'] as num?)?.toInt(),
      versesCount: (json['versesCount'] as num?)?.toInt(),
      verseMapping: (json['verseMapping'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$JuzModelResponseToJson(JuzModelResponse instance) => <String, dynamic>{
      'id': instance.id,
      'juzNumber': instance.juzNumber,
      'firstVerseId': instance.firstVerseId,
      'lastVerseId': instance.lastVerseId,
      'versesCount': instance.versesCount,
      'verseMapping': instance.verseMapping,
    };

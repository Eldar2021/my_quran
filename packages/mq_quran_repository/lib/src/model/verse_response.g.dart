// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerseResponse _$VerseResponseFromJson(Map<String, dynamic> json) => VerseResponse(
      id: (json['id'] as num).toInt(),
      verseKey: json['verse_key'] as String,
      textUthmani: json['text_uthmani'] as String,
    );

Map<String, dynamic> _$VerseResponseToJson(VerseResponse instance) => <String, dynamic>{
      'id': instance.id,
      'verse_key': instance.verseKey,
      'text_uthmani': instance.textUthmani,
    };

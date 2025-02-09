// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_data_verse_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranDataVerseUthmaniResponse _$QuranDataVerseUthmaniResponseFromJson(Map<String, dynamic> json) =>
    QuranDataVerseUthmaniResponse(
      id: (json['id'] as num).toInt(),
      verseKey: json['verse_key'] as String,
      textUtmani: json['text_uthmani'] as String,
    );

Map<String, dynamic> _$QuranDataVerseUthmaniResponseToJson(QuranDataVerseUthmaniResponse instance) => <String, dynamic>{
      'id': instance.id,
      'verse_key': instance.verseKey,
      'text_uthmani': instance.textUtmani,
    };

QuranDataVerseUthmaniSimpleResponse _$QuranDataVerseUthmaniSimpleResponseFromJson(Map<String, dynamic> json) =>
    QuranDataVerseUthmaniSimpleResponse(
      id: (json['id'] as num).toInt(),
      verseKey: json['verse_key'] as String,
      textUtmaniSimple: json['text_uthmani_simple'] as String,
    );

Map<String, dynamic> _$QuranDataVerseUthmaniSimpleResponseToJson(QuranDataVerseUthmaniSimpleResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'verse_key': instance.verseKey,
      'text_uthmani_simple': instance.textUtmaniSimple,
    };

QuranDataVerseImlaeiResponse _$QuranDataVerseImlaeiResponseFromJson(Map<String, dynamic> json) =>
    QuranDataVerseImlaeiResponse(
      id: (json['id'] as num).toInt(),
      verseKey: json['verse_key'] as String,
      textImlaei: json['text_imlaei'] as String,
    );

Map<String, dynamic> _$QuranDataVerseImlaeiResponseToJson(QuranDataVerseImlaeiResponse instance) => <String, dynamic>{
      'id': instance.id,
      'verse_key': instance.verseKey,
      'text_imlaei': instance.textImlaei,
    };

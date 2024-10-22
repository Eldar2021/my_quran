// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_page_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranPageResponse _$QuranPageResponseFromJson(Map<String, dynamic> json) =>
    QuranPageResponse(
      verses: (json['verses'] as List<dynamic>)
          .map((e) => VerseResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: MetaResponse.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuranPageResponseToJson(QuranPageResponse instance) =>
    <String, dynamic>{
      'verses': instance.verses,
      'meta': instance.meta,
    };

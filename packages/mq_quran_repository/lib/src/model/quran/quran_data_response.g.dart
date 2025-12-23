// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranDataResponse _$QuranDataResponseFromJson(
  Map<String, dynamic> json,
) => QuranDataResponse(
  verses: (json['verses'] as List<dynamic>)
      .map((e) => QuranDataVerseResponse.fromJson(e as Map<String, dynamic>))
      .toList(),
  meta: QuranDataMetaResponse.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$QuranDataResponseToJson(QuranDataResponse instance) =>
    <String, dynamic>{
      'verses': instance.verses,
      'meta': instance.meta,
    };

QuranDataMetaResponse _$QuranDataMetaResponseFromJson(
  Map<String, dynamic> json,
) => QuranDataMetaResponse(
  filters: QuranDataFilterResponse.fromJson(
    json['filters'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$QuranDataMetaResponseToJson(
  QuranDataMetaResponse instance,
) => <String, dynamic>{'filters': instance.filters};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurahResponse _$SurahResponseFromJson(Map<String, dynamic> json) => SurahResponse(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      aya: (json['aya'] as num).toInt(),
      pages: (json['pages'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
      arabic: json['arabic'] as String,
    );

Map<String, dynamic> _$SurahResponseToJson(SurahResponse instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'aya': instance.aya,
      'pages': instance.pages,
      'arabic': instance.arabic,
    };

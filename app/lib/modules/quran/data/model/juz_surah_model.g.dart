// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'juz_surah_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JuzSurahResponse _$JuzSurahResponseFromJson(Map<String, dynamic> json) =>
    JuzSurahResponse(
      name: json['name'] as String,
      arName: json['arName'] as String,
      pages: (json['pages'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$JuzSurahResponseToJson(JuzSurahResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'arName': instance.arName,
      'pages': instance.pages,
    };

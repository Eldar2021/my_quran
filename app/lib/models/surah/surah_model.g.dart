// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Surah _$SurahFromJson(Map<String, dynamic> json) => Surah(
      id: json['id'] as int,
      name: json['name'] as String,
      aya: json['aya'] as int,
      pages: (json['pages'] as List<dynamic>).map((e) => e as int).toList(),
      arabic: json['arabic'] as String,
    );

Map<String, dynamic> _$SurahToJson(Surah instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'aya': instance.aya,
      'pages': instance.pages,
      'arabic': instance.arabic,
    };

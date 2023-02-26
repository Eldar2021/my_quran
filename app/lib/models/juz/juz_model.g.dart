// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'juz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Juz _$JuzFromJson(Map<String, dynamic> json) => Juz(
      id: json['id'] as int,
      name: json['name'] as String,
      pages: (json['pages'] as List<dynamic>).map((e) => e as int).toList(),
      surahs: (json['surahs'] as List<dynamic>).map((e) => JuzSurah.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$JuzToJson(Juz instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pages': instance.pages,
      'surahs': instance.surahs,
    };

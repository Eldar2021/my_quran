// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'juz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JuzModel _$JuzResponseFromJson(Map<String, dynamic> json) => JuzModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      pages: (json['pages'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
      surahs: (json['surahs'] as List<dynamic>).map((e) => JuzSurahModel.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$JuzResponseToJson(JuzModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pages': instance.pages,
      'surahs': instance.surahs,
    };

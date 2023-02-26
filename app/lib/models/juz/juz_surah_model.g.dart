// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'juz_surah_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JuzSurah _$JuzSurahFromJson(Map<String, dynamic> json) => JuzSurah(
      name: json['name'] as String,
      arName: json['arName'] as String,
      pages: (json['pages'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$JuzSurahToJson(JuzSurah instance) => <String, dynamic>{
      'name': instance.name,
      'arName': instance.arName,
      'pages': instance.pages,
    };

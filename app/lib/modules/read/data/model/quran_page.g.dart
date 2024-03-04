// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranPage _$QuranPageFromJson(Map<String, dynamic> json) => QuranPage(
      verses: (json['verses'] as List<dynamic>).map((e) => Verse.fromJson(e as Map<String, dynamic>)).toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuranPageToJson(QuranPage instance) => <String, dynamic>{
      'verses': instance.verses,
      'meta': instance.meta,
    };

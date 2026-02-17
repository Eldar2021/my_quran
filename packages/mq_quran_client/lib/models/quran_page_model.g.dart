// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranPageModel _$QuranPageModelFromJson(Map<String, dynamic> json) => QuranPageModel(
  pageNumber: (json['pageNumber'] as num).toInt(),
  verses: (json['verses'] as List<dynamic>).map((e) => QuranVerseModel.fromJson(e as Map<String, dynamic>)).toList(),
);

Map<String, dynamic> _$QuranPageModelToJson(QuranPageModel instance) => <String, dynamic>{
  'pageNumber': instance.pageNumber,
  'verses': instance.verses,
};

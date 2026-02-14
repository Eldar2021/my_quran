// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_verse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranVerseModel _$QuranVerseModelFromJson(Map<String, dynamic> json) => QuranVerseModel(
  id: (json['id'] as num).toInt(),
  verseNumber: (json['verseNumber'] as num).toInt(),
  verseKey: json['verseKey'] as String,
  hizbNumber: (json['hizbNumber'] as num).toInt(),
  rubElHizbNumber: (json['rubElHizbNumber'] as num).toInt(),
  rukuNumber: (json['rukuNumber'] as num).toInt(),
  manzilNumber: (json['manzilNumber'] as num).toInt(),
  textImlaei: json['textImlaei'] as String,
  textUthmani: json['textUthmani'] as String,
  codeV2: json['codeV2'] as String,
  chapterId: (json['chapterId'] as num).toInt(),
  pageNumber: (json['pageNumber'] as num).toInt(),
  juzNumber: (json['juzNumber'] as num).toInt(),
  sajdahNumber: (json['sajdahNumber'] as num?)?.toInt(),
);

Map<String, dynamic> _$QuranVerseModelToJson(QuranVerseModel instance) => <String, dynamic>{
  'id': instance.id,
  'verseNumber': instance.verseNumber,
  'verseKey': instance.verseKey,
  'hizbNumber': instance.hizbNumber,
  'rubElHizbNumber': instance.rubElHizbNumber,
  'rukuNumber': instance.rukuNumber,
  'manzilNumber': instance.manzilNumber,
  'textImlaei': instance.textImlaei,
  'textUthmani': instance.textUthmani,
  'codeV2': instance.codeV2,
  'chapterId': instance.chapterId,
  'pageNumber': instance.pageNumber,
  'juzNumber': instance.juzNumber,
  'sajdahNumber': instance.sajdahNumber,
};

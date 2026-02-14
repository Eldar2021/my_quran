// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_verse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranVerseModel _$QuranVerseModelFromJson(Map<String, dynamic> json) => QuranVerseModel(
  id: (json['id'] as num).toInt(),
  verseNumber: (json['verse_number'] as num).toInt(),
  verseKey: json['verse_key'] as String,
  hizbNumber: (json['hizb_number'] as num).toInt(),
  rubElHizbNumber: (json['rub_el_hizb_number'] as num).toInt(),
  rukuNumber: (json['ruku_number'] as num).toInt(),
  manzilNumber: (json['manzil_number'] as num).toInt(),
  textImlaei: json['text_imlaei'] as String,
  textUthmani: json['text_uthmani'] as String,
  codeV2: json['code_v2'] as String,
  chapterId: (json['chapter_id'] as num).toInt(),
  pageNumber: (json['page_number'] as num).toInt(),
  juzNumber: (json['juz_number'] as num).toInt(),
  sajdahNumber: (json['sajdah_number'] as num?)?.toInt(),
);

Map<String, dynamic> _$QuranVerseModelToJson(QuranVerseModel instance) => <String, dynamic>{
  'id': instance.id,
  'verse_number': instance.verseNumber,
  'verse_key': instance.verseKey,
  'hizb_number': instance.hizbNumber,
  'rub_el_hizb_number': instance.rubElHizbNumber,
  'ruku_number': instance.rukuNumber,
  'manzil_number': instance.manzilNumber,
  'text_imlaei': instance.textImlaei,
  'text_uthmani': instance.textUthmani,
  'code_v2': instance.codeV2,
  'chapter_id': instance.chapterId,
  'page_number': instance.pageNumber,
  'juz_number': instance.juzNumber,
  'sajdah_number': instance.sajdahNumber,
};

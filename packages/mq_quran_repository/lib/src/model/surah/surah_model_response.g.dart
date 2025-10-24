// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurahModelResponse _$SurahModelResponseFromJson(Map<String, dynamic> json) => SurahModelResponse(
  id: (json['id'] as num).toInt(),
  versesCount: (json['verses_count'] as num).toInt(),
  revelationPlace: json['revelation_place'] as String,
  revelationOrder: (json['revelation_order'] as num).toInt(),
  bismillahPre: json['bismillah_pre'] as bool,
  nameSimple: json['name_simple'] as String,
  nameComplex: json['name_complex'] as String,
  nameArabic: json['name_arabic'] as String,
  pages: (json['pages'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
);

Map<String, dynamic> _$SurahModelResponseToJson(SurahModelResponse instance) => <String, dynamic>{
  'id': instance.id,
  'revelation_place': instance.revelationPlace,
  'revelation_order': instance.revelationOrder,
  'bismillah_pre': instance.bismillahPre,
  'name_simple': instance.nameSimple,
  'name_complex': instance.nameComplex,
  'name_arabic': instance.nameArabic,
  'verses_count': instance.versesCount,
  'pages': instance.pages,
};

TranslatedName _$TranslatedNameFromJson(Map<String, dynamic> json) => TranslatedName(
  languageName: json['language_name'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$TranslatedNameToJson(TranslatedName instance) => <String, dynamic>{
  'language_name': instance.languageName,
  'name': instance.name,
};

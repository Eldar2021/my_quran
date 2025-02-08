// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurahModelResponse _$SurahModelResponseFromJson(Map<String, dynamic> json) => SurahModelResponse(
      id: (json['id'] as num).toInt(),
      versesCount: (json['versesCount'] as num).toInt(),
      revelationPlace: json['revelationPlace'] as String,
      revelationOrder: (json['revelationOrder'] as num).toInt(),
      bismillahPre: json['bismillahPre'] as bool,
      nameSimple: json['nameSimple'] as String,
      nameComplex: json['nameComplex'] as String,
      nameArabic: json['nameArabic'] as String,
      pages: (json['pages'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
      translatedName: TranslatedName.fromJson(json['translatedName'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SurahModelResponseToJson(SurahModelResponse instance) => <String, dynamic>{
      'id': instance.id,
      'revelationPlace': instance.revelationPlace,
      'revelationOrder': instance.revelationOrder,
      'bismillahPre': instance.bismillahPre,
      'nameSimple': instance.nameSimple,
      'nameComplex': instance.nameComplex,
      'nameArabic': instance.nameArabic,
      'versesCount': instance.versesCount,
      'pages': instance.pages,
      'translatedName': instance.translatedName,
    };

TranslatedName _$TranslatedNameFromJson(Map<String, dynamic> json) => TranslatedName(
      languageName: json['languageName'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$TranslatedNameToJson(TranslatedName instance) => <String, dynamic>{
      'languageName': instance.languageName,
      'name': instance.name,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorldCountry _$WorldCountryFromJson(Map<String, dynamic> json) => WorldCountry(
  code: json['code'] as String,
  codeShort: json['codeShort'] as String,
  emoji: json['emoji'] as String,
  officialEn: json['officialEn'] as String,
  commonEn: json['commonEn'] as String,
  nameNative: json['nameNative'] as String,
  commonNative: json['commonNative'] as String,
  altSpellings: (json['altSpellings'] as List<dynamic>).map((e) => e as String).toList(),
  timezones: (json['timezones'] as List<dynamic>).map((e) => e as String).toList(),
  idd: CountryIdd.fromJson(json['idd'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WorldCountryToJson(WorldCountry instance) => <String, dynamic>{
  'code': instance.code,
  'codeShort': instance.codeShort,
  'emoji': instance.emoji,
  'officialEn': instance.officialEn,
  'commonEn': instance.commonEn,
  'nameNative': instance.nameNative,
  'commonNative': instance.commonNative,
  'altSpellings': instance.altSpellings,
  'timezones': instance.timezones,
  'idd': instance.idd,
};

CountryIdd _$CountryIddFromJson(Map<String, dynamic> json) => CountryIdd(
  root: (json['root'] as num).toInt(),
  suffixes: (json['suffixes'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
);

Map<String, dynamic> _$CountryIddToJson(CountryIdd instance) => <String, dynamic>{
  'root': instance.root,
  'suffixes': instance.suffixes,
};

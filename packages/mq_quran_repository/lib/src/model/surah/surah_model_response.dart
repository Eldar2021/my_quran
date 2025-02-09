import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

part 'surah_model_response.g.dart';

@JsonSerializable()
@immutable
final class SurahModelResponse {
  const SurahModelResponse({
    required this.id,
    required this.versesCount,
    required this.revelationPlace,
    required this.revelationOrder,
    required this.bismillahPre,
    required this.nameSimple,
    required this.nameComplex,
    required this.nameArabic,
    required this.pages,
  });

  factory SurahModelResponse.fromJson(Map<String, dynamic> json) => _$SurahModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SurahModelResponseToJson(this);

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'revelation_place')
  final String revelationPlace;
  @JsonKey(name: 'revelation_order')
  final int revelationOrder;
  @JsonKey(name: 'bismillah_pre')
  final bool bismillahPre;
  @JsonKey(name: 'name_simple')
  final String nameSimple;
  @JsonKey(name: 'name_complex')
  final String nameComplex;
  @JsonKey(name: 'name_arabic')
  final String nameArabic;
  @JsonKey(name: 'verses_count')
  final int versesCount;
  @JsonKey(name: 'pages')
  final List<int> pages;

  MqSurahEntity toEntity() {
    return MqSurahEntity(
      id: id,
      revelationPlace: revelationPlace,
      revelationOrder: revelationOrder,
      bismillahPre: bismillahPre,
      nameSimple: nameSimple,
      nameComplex: nameComplex,
      nameArabic: nameArabic,
      versesCount: versesCount,
      pages: pages,
    );
  }
}

@JsonSerializable()
@immutable
final class TranslatedName {
  const TranslatedName({
    required this.languageName,
    required this.name,
  });

  factory TranslatedName.fromJson(Map<String, dynamic> json) => _$TranslatedNameFromJson(json);
  Map<String, dynamic> toJson() => _$TranslatedNameToJson(this);

  @JsonKey(name: 'language_name')
  final String languageName;
  @JsonKey(name: 'name')
  final String name;

  MqSurahTranslatedNameEntity toEntity() {
    return MqSurahTranslatedNameEntity(
      languageName: languageName,
      name: name,
    );
  }
}

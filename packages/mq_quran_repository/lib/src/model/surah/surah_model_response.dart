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
    required this.translatedName,
  });

  factory SurahModelResponse.fromJson(Map<String, dynamic> json) => _$SurahModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SurahModelResponseToJson(this);

  final int id;
  final String revelationPlace;
  final int revelationOrder;
  final bool bismillahPre;
  final String nameSimple;
  final String nameComplex;
  final String nameArabic;
  final int versesCount;
  final List<int> pages;
  final TranslatedName translatedName;

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
      translatedName: translatedName.toEntity(),
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

  final String languageName;
  final String name;

  MqSurahTranslatedNameEntity toEntity() {
    return MqSurahTranslatedNameEntity(
      languageName: languageName,
      name: name,
    );
  }
}

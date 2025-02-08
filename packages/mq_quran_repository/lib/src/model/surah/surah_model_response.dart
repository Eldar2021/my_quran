import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'surah_model_response.g.dart';

@JsonSerializable()
@immutable
final class SurahModelResponse {
  const SurahModelResponse({
    this.id,
    this.versesCount,
    this.revelationPlace,
    this.revelationOrder,
    this.bismillahPre,
    this.nameSimple,
    this.nameComplex,
    this.nameArabic,
    this.pages,
    this.translatedName,
  });

  factory SurahModelResponse.fromJson(Map<String, dynamic> json) => _$SurahModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SurahModelResponseToJson(this);

  final int? id;
  final String? revelationPlace;
  final int? revelationOrder;
  final bool? bismillahPre;
  final String? nameSimple;
  final String? nameComplex;
  final String? nameArabic;
  final int? versesCount;
  final List<int>? pages;
  final TranslatedName? translatedName;
}

@JsonSerializable()
@immutable
final class TranslatedName {
  const TranslatedName({
    this.languageName,
    this.name,
  });

  final String? languageName;
  final String? name;
}

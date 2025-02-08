import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quran_data_filter_response.g.dart';

abstract interface class QuranDataFilterResponse {
  const QuranDataFilterResponse({
    required this.value,
  });

  factory QuranDataFilterResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('page_number')) {
      return QuranDataFilterPageNumber.fromJson(json);
    } else if (json.containsKey('juz_number')) {
      return QuranDataFilterJuzNumber.fromJson(json);
    } else if (json.containsKey('chapter_number')) {
      return QuranDataFilterSurahNumber.fromJson(json);
    } else {
      throw Exception('Unknown QuranDataFilterResponse');
    }
  }

  Map<String, dynamic> toJson() {
    if (this is QuranDataFilterPageNumber) {
      return (this as QuranDataFilterPageNumber).toJson();
    } else if (this is QuranDataFilterJuzNumber) {
      return (this as QuranDataFilterJuzNumber).toJson();
    } else if (this is QuranDataFilterSurahNumber) {
      return (this as QuranDataFilterSurahNumber).toJson();
    } else {
      throw Exception('Unknown QuranDataFilterResponse');
    }
  }

  final String value;
}

@JsonSerializable()
@immutable
final class QuranDataFilterPageNumber extends QuranDataFilterResponse {
  const QuranDataFilterPageNumber({
    required this.pageNumber,
  }) : super(value: pageNumber);

  factory QuranDataFilterPageNumber.fromJson(Map<String, dynamic> json) => _$QuranDataFilterPageNumberFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuranDataFilterPageNumberToJson(this);

  @JsonKey(name: 'page_number')
  final String pageNumber;
}

@JsonSerializable()
@immutable
final class QuranDataFilterJuzNumber extends QuranDataFilterResponse {
  const QuranDataFilterJuzNumber({
    required this.juzNumber,
  }) : super(value: juzNumber);

  factory QuranDataFilterJuzNumber.fromJson(Map<String, dynamic> json) => _$QuranDataFilterJuzNumberFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuranDataFilterJuzNumberToJson(this);

  @JsonKey(name: 'juz_number')
  final String juzNumber;
}

@JsonSerializable()
@immutable
final class QuranDataFilterSurahNumber extends QuranDataFilterResponse {
  const QuranDataFilterSurahNumber({
    required this.surahNumber,
  }) : super(value: surahNumber);

  factory QuranDataFilterSurahNumber.fromJson(Map<String, dynamic> json) => _$QuranDataFilterSurahNumberFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuranDataFilterSurahNumberToJson(this);

  @JsonKey(name: 'chapter_number')
  final String surahNumber;
}

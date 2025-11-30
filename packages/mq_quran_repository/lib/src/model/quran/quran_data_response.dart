import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

part 'quran_data_response.g.dart';

@JsonSerializable()
@immutable
final class QuranDataResponse {
  const QuranDataResponse({
    required this.verses,
    required this.meta,
  });

  factory QuranDataResponse.fromJson(Map<String, dynamic> json) {
    return _$QuranDataResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuranDataResponseToJson(this);
  }

  @JsonKey(name: 'verses')
  final List<QuranDataVerseResponse> verses;
  @JsonKey(name: 'meta')
  final QuranDataMetaResponse meta;

  QuranDataEntity toEntity() {
    return QuranDataEntity(
      verses: verses.map((e) => e.toEntity()).toList(),
      meta: meta.toEntity(),
    );
  }
}

@JsonSerializable()
@immutable
final class QuranDataMetaResponse {
  const QuranDataMetaResponse({
    required this.filters,
  });

  factory QuranDataMetaResponse.fromJson(Map<String, dynamic> json) {
    return _$QuranDataMetaResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuranDataMetaResponseToJson(this);
  }

  @JsonKey(name: 'filters')
  final QuranDataFilterResponse filters;

  QuranDataMetaEntity toEntity() {
    return QuranDataMetaEntity(
      filters: filters.toEntity(),
    );
  }
}

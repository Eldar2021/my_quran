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

  factory QuranDataResponse.fromJson(Map<String, dynamic> json) => _$QuranDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuranDataResponseToJson(this);

  @JsonKey(name: 'verses')
  final List<QuranDataVerseResponse> verses;
  @JsonKey(name: 'meta')
  final QuranDataMetaResponse meta;
}

@JsonSerializable()
@immutable
final class QuranDataMetaResponse {
  const QuranDataMetaResponse({
    required this.filters,
  });

  factory QuranDataMetaResponse.fromJson(Map<String, dynamic> json) => _$QuranDataMetaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuranDataMetaResponseToJson(this);

  @JsonKey(name: 'filters')
  final QuranDataFilterResponse filters;
}

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

part 'meta_response.g.dart';

@immutable
@JsonSerializable()
final class MetaResponse {
  const MetaResponse({required this.filters});

  factory MetaResponse.fromJson(Map<String, dynamic> json) => _$MetaResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MetaResponseToJson(this);

  final FiltersResponse filters;
}

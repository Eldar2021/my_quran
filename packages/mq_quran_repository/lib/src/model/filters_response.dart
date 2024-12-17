import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filters_response.g.dart';

@immutable
@JsonSerializable()
final class FiltersResponse {
  const FiltersResponse({required this.pageNumber});

  factory FiltersResponse.fromJson(Map<String, dynamic> json) => _$FiltersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FiltersResponseToJson(this);

  @JsonKey(name: 'page_number')
  final String pageNumber;
}

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filters.g.dart';

@immutable
@JsonSerializable()
final class Filters {
  const Filters({required this.pageNumber});

  factory Filters.fromJson(Map<String, dynamic> json) => _$FiltersFromJson(json);
  Map<String, dynamic> toJson() => _$FiltersToJson(this);

  @JsonKey(name: 'page_number')
  final String pageNumber;
}

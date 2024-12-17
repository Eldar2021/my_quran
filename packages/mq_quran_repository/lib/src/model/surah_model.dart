import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'surah_model.g.dart';

@immutable
@JsonSerializable()
final class SurahResponse {
  const SurahResponse({
    required this.id,
    required this.name,
    required this.aya,
    required this.pages,
    required this.arabic,
  });

  factory SurahResponse.fromJson(Map<String, dynamic> json) => _$SurahResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SurahResponseToJson(this);

  final int id;
  final String name;
  final int aya;
  final List<int> pages;
  final String arabic;
}

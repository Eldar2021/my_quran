import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'juz_surah_model.g.dart';

@JsonSerializable()
@immutable
final class JuzSurahResponse {
  const JuzSurahResponse({
    required this.name,
    required this.arName,
    required this.pages,
  });

  factory JuzSurahResponse.fromJson(Map<String, dynamic> json) => _$JuzSurahResponseFromJson(json);
  Map<String, dynamic> toJson() => _$JuzSurahResponseToJson(this);

  final String name;
  final String arName;
  final List<int> pages;
}

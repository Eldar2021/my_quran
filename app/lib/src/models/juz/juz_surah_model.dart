import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'juz_surah_model.g.dart';

@immutable
@JsonSerializable()
final class JuzSurah {
  const JuzSurah({
    required this.name,
    required this.arName,
    required this.pages,
  });

  factory JuzSurah.fromJson(Map<String, dynamic> json) => _$JuzSurahFromJson(json);
  Map<String, dynamic> toJson() => _$JuzSurahToJson(this);

  final String name;
  final String arName;
  final List<int> pages;
}

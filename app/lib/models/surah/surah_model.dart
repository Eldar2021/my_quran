import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'surah_model.g.dart';

@immutable
@JsonSerializable()
final class Surah {
  const Surah({
    required this.id,
    required this.name,
    required this.aya,
    required this.pages,
    required this.arabic,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => _$SurahFromJson(json);
  Map<String, dynamic> toJson() => _$SurahToJson(this);

  final int id;
  final String name;
  final int aya;
  final List<int> pages;
  final String arabic;

  String get surahPath {
    if (id < 10) return '00$id';
    if (id < 100) return '0$id';
    return '$id';
  }
}

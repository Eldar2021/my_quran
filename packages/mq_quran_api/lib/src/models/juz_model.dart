import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_quran_api/src/models/juz_surah_model.dart';

part 'juz_model.g.dart';

@immutable
@JsonSerializable()
final class JuzModel {
  const JuzModel({
    required this.id,
    required this.name,
    required this.pages,
    required this.surahs,
  });

  factory JuzModel.fromJson(Map<String, dynamic> json) => _$JuzResponseFromJson(json);
  Map<String, dynamic> toJson() => _$JuzResponseToJson(this);

  final int id;
  final String name;
  final List<int> pages;
  final List<JuzSurahModel> surahs;
}

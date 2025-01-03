import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

part 'juz_model.g.dart';

@JsonSerializable()
@immutable
final class JuzResponse {
  const JuzResponse({
    required this.id,
    required this.name,
    required this.pages,
    required this.surahs,
  });

  factory JuzResponse.fromJson(Map<String, dynamic> json) => _$JuzResponseFromJson(json);
  Map<String, dynamic> toJson() => _$JuzResponseToJson(this);

  final int id;
  final String name;
  final List<int> pages;
  final List<JuzSurahResponse> surahs;
}

import 'package:json_annotation/json_annotation.dart';

import 'package:hatim/models/models.dart';

part 'juz_model.g.dart';

@JsonSerializable()
class Juz {
  const Juz({
    required this.id,
    required this.name,
    required this.pages,
    required this.surahs,
  });

  factory Juz.fromJson(Map<String, dynamic> json) => _$JuzFromJson(json);
  Map<String, dynamic> toJson() => _$JuzToJson(this);

  final int id;
  final String name;
  final List<int> pages;
  final List<JuzSurah> surahs;
}

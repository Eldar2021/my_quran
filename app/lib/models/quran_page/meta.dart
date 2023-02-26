import 'package:json_annotation/json_annotation.dart';

import 'package:my_quran/models/models.dart';

part 'meta.g.dart';

@JsonSerializable()
class Meta {
  const Meta({required this.filters});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map<String, dynamic> toJson() => _$MetaToJson(this);

  final Filters filters;
}

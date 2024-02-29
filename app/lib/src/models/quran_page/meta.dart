import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:my_quran/src/models/models.dart';

part 'meta.g.dart';

@immutable
@JsonSerializable()
final class Meta {
  const Meta({required this.filters});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map<String, dynamic> toJson() => _$MetaToJson(this);

  final Filters filters;
}

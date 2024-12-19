import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mq_hatim_base_response.g.dart';

@JsonSerializable()
@immutable
final class HatimBaseResponse {
  const HatimBaseResponse({
    required this.type,
    required this.data,
  });

  factory HatimBaseResponse.fromJson(Map<String, dynamic> json) => _$HatimBaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HatimBaseResponseToJson(this);

  final HatimResponseType type;
  final dynamic data;
}

enum HatimResponseType {
  @JsonValue('list_of_juz')
  listOfJuz,

  @JsonValue('list_of_page')
  listOfPage,

  @JsonValue('user_pages')
  userPages,
}

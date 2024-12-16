import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mq_home_model_response.g.dart';

@JsonSerializable()
@immutable
final class MqHomeModelResponse {
  const MqHomeModelResponse({
    required this.allDoneHatims,
    required this.allDonePages,
    required this.donePages,
  });

  factory MqHomeModelResponse.fromJson(Map<String, dynamic> json) => _$HomeModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeModelResponseToJson(this);

  final int allDoneHatims;
  final int allDonePages;
  final int donePages;
}

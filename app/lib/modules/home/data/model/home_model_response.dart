import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_model_response.g.dart';

@JsonSerializable()
@immutable
final class HomeModelResponse {
  const HomeModelResponse({
    required this.allDoneHatims,
    required this.allDonePages,
    required this.donePages,
  });

  factory HomeModelResponse.fromJson(Map<String, dynamic> json) => _$HomeModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeModelResponseToJson(this);

  final int allDoneHatims;
  final int allDonePages;
  final int donePages;
}

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mq_hatim_create_model.g.dart';

@JsonSerializable()
@immutable
final class MqHatimCreateModel {
  const MqHatimCreateModel({
    required this.title,
    required this.description,
    required this.type,
    required this.participants,
  });

  factory MqHatimCreateModel.fromJson(Map<String, dynamic> json) => _$MqHatimCreateModelFromJson(json);
  Map<String, dynamic> toJson() => _$MqHatimCreateModelToJson(this);

  final String title;
  final String description;
  final String type;
  final List<String> participants;
}

@immutable
final class MqHatimUpdateModel {
  const MqHatimUpdateModel({
    required this.id,
    required this.data,
  });

  final String id;
  final MqHatimCreateModel data;
}

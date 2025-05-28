import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mq_hatim_creator_model.g.dart';

@JsonSerializable()
@immutable
final class MqHatimCreatorModel {
  const MqHatimCreatorModel({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.avatar,
  });

  factory MqHatimCreatorModel.fromJson(Map<String, dynamic> json) => _$MqHatimCreatorModelFromJson(json);
  Map<String, dynamic> toJson() => _$MqHatimCreatorModelToJson(this);

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  @JsonKey(name: 'username')
  final String userName;
  final String email;
  final String? avatar;
}

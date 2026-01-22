import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mq_user_hatim_model.g.dart';

@JsonSerializable()
@immutable
final class MqUserHatimModel {
  const MqUserHatimModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.avatar,
  });

  factory MqUserHatimModel.fromJson(Map<String, dynamic> json) => _$MqUserHatimModelFromJson(json);
  Map<String, dynamic> toJson() => _$MqUserHatimModelToJson(this);

  final int id;

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  @JsonKey(name: 'username')
  final String? userName;

  final String? email;

  final String? avatar;
}

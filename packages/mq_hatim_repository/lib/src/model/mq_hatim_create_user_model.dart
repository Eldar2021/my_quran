import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mq_hatim_create_user_model.g.dart';

@JsonSerializable()
@immutable
final class MqHatimCreateUserModel {
  const MqHatimCreateUserModel({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.avatar,
  });

  factory MqHatimCreateUserModel.fromJson(Map<String, dynamic> json) => _$MqHatimCreateUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$MqHatimCreateUserModelToJson(this);

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  @JsonKey(name: 'username')
  final String userName;

  final String email;

  final String? avatar;
}

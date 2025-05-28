import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mq_home_user_model.g.dart';

@JsonSerializable()
@immutable
final class MqHomeUserModel {
  const MqHomeUserModel({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.avatar,
  });

  factory MqHomeUserModel.fromJson(Map<String, dynamic> json) => _$MqHomeUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$MqHomeUserModelToJson(this);

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  @JsonKey(name: 'username')
  final String userName;
  final String email;
  final String? avatar;
}

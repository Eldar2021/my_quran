import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mq_user_id_model.g.dart';

@JsonSerializable()
@immutable
final class MqUserIdModel {
  const MqUserIdModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory MqUserIdModel.fromJson(Map<String, dynamic> json) => _$MqUserIdModelFromJson(json);
  Map<String, dynamic> toJson() => _$MqUserIdModelToJson(this);

  final int? id;

  @JsonKey(name: 'username')
  final String? userName;

  final String? email;

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  // final String? avatar;
}

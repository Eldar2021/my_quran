import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';

part 'mq_search_model.g.dart';

@JsonSerializable()
@immutable
final class MqSearchModel {
  const MqSearchModel({required this.users});

  factory MqSearchModel.fromJson(Map<String, dynamic> json) => _$MqSearchModelFromJson(json);
  Map<String, dynamic> toJson() => _$MqSearchModelToJson(this);

  final List<MqUserIdModel>? users;
}

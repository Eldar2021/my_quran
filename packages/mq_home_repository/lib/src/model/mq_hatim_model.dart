import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_home_repository/mq_home_repository.dart';

part 'mq_hatim_model.g.dart';

@JsonSerializable()
@immutable
final class MqHatimsModel {
  const MqHatimsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.creator,
  });

  factory MqHatimsModel.fromJson(Map<String, dynamic> json) => _$MqHatimsModelFromJson(json);
  Map<String, dynamic> toJson() => _$MqHatimsModelToJson(this);

  final String id;
  final String? title;
  final String? description;
  final String type;
  final String status;
  final MqHatimCreatorModel? creator;

  bool isCreator(String value) {
    return creator?.userName == value;
  }

  String? get uiTitle {
    if (title == null) return null;
    if (title!.contains('General')) return null;
    return title;
  }
}

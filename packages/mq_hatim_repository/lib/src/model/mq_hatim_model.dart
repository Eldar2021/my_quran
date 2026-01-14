import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';

part 'mq_hatim_model.g.dart';

@JsonSerializable()
@immutable
final class MqHatimModel {
  const MqHatimModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.creator,
    required this.participants,
  });

  factory MqHatimModel.fromJson(Map<String, dynamic> json) => _$MqHatimModelFromJson(json);
  Map<String, dynamic> toJson() => _$MqHatimModelToJson(this);

  final String id;
  final String? title;
  final String? description;
  final String type;
  final String status;
  final MqHatimCreateUserModel? creator;

  @JsonKey(name: 'participants_details')
  final List<MqHatimParticipantModel>? participants;
}

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
    required this.participantsDetails,
  });

  factory MqHatimsModel.fromJson(Map<String, dynamic> json) => _$MqHatimsModelFromJson(json);
  Map<String, dynamic> toJson() => _$MqHatimsModelToJson(this);

  final String id;
  final String? title;
  final String? description;
  final String type;
  final String status;
  final MqHatimCreatorModel? creator;

  @JsonKey(name: 'participants_details')
  final List<MqHatimParticipantsDetailModel>? participantsDetails;
}

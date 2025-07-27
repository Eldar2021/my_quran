import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_home_repository/mq_home_repository.dart';

part 'mq_home_invited_hatims_model.g.dart';

@JsonSerializable()
@immutable
final class MqHomeInvitedHatimsModel {
  const MqHomeInvitedHatimsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.creator,
    required this.participantsDetails,
  });

  factory MqHomeInvitedHatimsModel.fromJson(Map<String, dynamic> json) => _$MqHomeInvitedHatimsModelFromJson(json);
  Map<String, dynamic> toJson() => _$MqHomeInvitedHatimsModelToJson(this);

  final String id;
  final String? title;
  final String? description;
  final String type;
  final String status;
  final MqHatimCreatorModel? creator;
  final List<MqHatimParticipantsDetailModel>? participantsDetails;
}

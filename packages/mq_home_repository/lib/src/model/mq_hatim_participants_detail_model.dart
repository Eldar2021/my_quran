import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_home_repository/mq_home_repository.dart';

part 'mq_hatim_participants_detail_model.g.dart';

@JsonSerializable()
@immutable
final class MqHatimParticipantsDetailModel {
  const MqHatimParticipantsDetailModel({
    required this.id,
    required this.hatim,
    required this.user,
    required this.accepted,
  });

  factory MqHatimParticipantsDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MqHatimParticipantsDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$MqHatimParticipantsDetailModelToJson(this);

  final int id;
  final String hatim;
  final MqHomeUserModel user;
  final bool accepted;
}

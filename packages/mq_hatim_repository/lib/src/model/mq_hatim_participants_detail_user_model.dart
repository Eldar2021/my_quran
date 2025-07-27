import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';

part 'mq_hatim_participants_detail_user_model.g.dart';

@JsonSerializable()
@immutable
final class MqHatimParticipantsDetailUserModel {
  const MqHatimParticipantsDetailUserModel({
    required this.id,
    required this.hatim,
    required this.user,
    required this.accepted,
  });

  factory MqHatimParticipantsDetailUserModel.fromJson(Map<String, dynamic> json) =>
      _$MqHatimParticipantsDetailUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$MqHatimParticipantsDetailUserModelToJson(this);

  final int id;
  final String hatim;
  final MqUserHatimModel? user;
  final bool accepted;
}

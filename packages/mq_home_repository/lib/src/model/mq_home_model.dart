import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_home_repository/mq_home_repository.dart';

part 'mq_home_model.g.dart';

@JsonSerializable()
@immutable
final class MqHomeModel extends Equatable {
  const MqHomeModel({
    required this.allDoneHatims,
    required this.allDonePages,
    required this.donePages,
    required this.enableCreationHatim,
    required this.invitedHatims,
    required this.hatims,
  });

  factory MqHomeModel.fromJson(Map<String, dynamic> json) => _$MqHomeModelFromJson(json);
  Map<String, dynamic> toJson() => _$MqHomeModelToJson(this);

  final int allDoneHatims;
  final int allDonePages;
  final int donePages;
  final bool enableCreationHatim;
  final List<MqHomeInvitedHatimsModel>? invitedHatims;
  final List<MqHatimsModel>? hatims;

  @override
  List<Object?> get props => [
    allDoneHatims,
    allDonePages,
    donePages,
    enableCreationHatim,
    invitedHatims,
    hatims,
  ];
}

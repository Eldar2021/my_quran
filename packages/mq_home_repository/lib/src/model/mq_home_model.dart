import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mq_home_model.g.dart';

@JsonSerializable()
@immutable
final class MqHomeModel {
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
  final List<MqHomeHatimsModel>? hatims;
}

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
  final List<MqHomeCreatorModel>? creator;
  final List<MqHomeParticipantsDetailsModel>? participantsDetails;
}

@JsonSerializable()
@immutable
final class MqHomeCreatorModel {
  const MqHomeCreatorModel({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.avatar,
  });

  factory MqHomeCreatorModel.fromJson(Map<String, dynamic> json) => _$MqHomeCreatorModelFromJson(json);
  Map<String, dynamic> toJson() => _$MqHomeCreatorModelToJson(this);

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  @JsonKey(name: 'username')
  final String userName;
  final String email;
  final String? avatar;
}

@JsonSerializable()
@immutable
final class MqHomeParticipantsDetailsModel {
  const MqHomeParticipantsDetailsModel({
    required this.id,
    required this.hatim,
    required this.user,
    required this.accepted,
  });

  factory MqHomeParticipantsDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$MqHomeParticipantsDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$MqHomeParticipantsDetailsModelToJson(this);

  final int id;
  final String hatim;
  final MqHomeUserModel user;
  final bool accepted;
}

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

@JsonSerializable()
@immutable
final class MqHomeHatimsModel {
  const MqHomeHatimsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.creator,
    required this.participantsDetails,
  });

  factory MqHomeHatimsModel.fromJson(Map<String, dynamic> json) => _$MqHomeHatimsModelFromJson(json);
  Map<String, dynamic> toJson() => _$MqHomeHatimsModelToJson(this);

  final String id;
  final String? title;
  final String? description;
  final String type;
  final String status;
  final List<MqHomeCreatorModel>? creator;
  final List<MqHomeParticipantsDetailsModel>? participantsDetails;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mq_home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MqHomeModel _$MqHomeModelFromJson(Map<String, dynamic> json) => MqHomeModel(
  allDoneHatims: (json['allDoneHatims'] as num).toInt(),
  allDonePages: (json['allDonePages'] as num).toInt(),
  donePages: (json['donePages'] as num).toInt(),
  enableCreationHatim: json['enableCreationHatim'] as bool,
  invitedHatims:
      (json['invitedHatims'] as List<dynamic>?)
          ?.map((e) => MqHomeInvitedHatimsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  hatims:
      (json['hatims'] as List<dynamic>?)?.map((e) => MqHomeHatimsModel.fromJson(e as Map<String, dynamic>)).toList(),
);

Map<String, dynamic> _$MqHomeModelToJson(MqHomeModel instance) => <String, dynamic>{
  'allDoneHatims': instance.allDoneHatims,
  'allDonePages': instance.allDonePages,
  'donePages': instance.donePages,
  'enableCreationHatim': instance.enableCreationHatim,
  'invitedHatims': instance.invitedHatims,
  'hatims': instance.hatims,
};

MqHomeInvitedHatimsModel _$MqHomeInvitedHatimsModelFromJson(Map<String, dynamic> json) => MqHomeInvitedHatimsModel(
  id: json['id'] as String,
  title: json['title'] as String?,
  description: json['description'] as String?,
  type: json['type'] as String,
  status: json['status'] as String,
  creator:
      (json['creator'] as List<dynamic>?)?.map((e) => MqHomeCreatorModel.fromJson(e as Map<String, dynamic>)).toList(),
  participantsDetails:
      (json['participantsDetails'] as List<dynamic>?)
          ?.map((e) => MqHomeParticipantsDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$MqHomeInvitedHatimsModelToJson(MqHomeInvitedHatimsModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'type': instance.type,
  'status': instance.status,
  'creator': instance.creator,
  'participantsDetails': instance.participantsDetails,
};

MqHomeCreatorModel _$MqHomeCreatorModelFromJson(Map<String, dynamic> json) => MqHomeCreatorModel(
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  userName: json['username'] as String,
  email: json['email'] as String,
  avatar: json['avatar'] as String?,
);

Map<String, dynamic> _$MqHomeCreatorModelToJson(MqHomeCreatorModel instance) => <String, dynamic>{
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'username': instance.userName,
  'email': instance.email,
  'avatar': instance.avatar,
};

MqHomeParticipantsDetailsModel _$MqHomeParticipantsDetailsModelFromJson(Map<String, dynamic> json) =>
    MqHomeParticipantsDetailsModel(
      id: (json['id'] as num).toInt(),
      hatim: json['hatim'] as String,
      user: MqHomeUserModel.fromJson(json['user'] as Map<String, dynamic>),
      accepted: json['accepted'] as bool,
    );

Map<String, dynamic> _$MqHomeParticipantsDetailsModelToJson(MqHomeParticipantsDetailsModel instance) =>
    <String, dynamic>{'id': instance.id, 'hatim': instance.hatim, 'user': instance.user, 'accepted': instance.accepted};

MqHomeUserModel _$MqHomeUserModelFromJson(Map<String, dynamic> json) => MqHomeUserModel(
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  userName: json['username'] as String,
  email: json['email'] as String,
  avatar: json['avatar'] as String?,
);

Map<String, dynamic> _$MqHomeUserModelToJson(MqHomeUserModel instance) => <String, dynamic>{
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'username': instance.userName,
  'email': instance.email,
  'avatar': instance.avatar,
};

MqHomeHatimsModel _$MqHomeHatimsModelFromJson(Map<String, dynamic> json) => MqHomeHatimsModel(
  id: json['id'] as String,
  title: json['title'] as String?,
  description: json['description'] as String?,
  type: json['type'] as String,
  status: json['status'] as String,
  creator:
      (json['creator'] as List<dynamic>?)?.map((e) => MqHomeCreatorModel.fromJson(e as Map<String, dynamic>)).toList(),
  participantsDetails:
      (json['participantsDetails'] as List<dynamic>?)
          ?.map((e) => MqHomeParticipantsDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$MqHomeHatimsModelToJson(MqHomeHatimsModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'type': instance.type,
  'status': instance.status,
  'creator': instance.creator,
  'participantsDetails': instance.participantsDetails,
};

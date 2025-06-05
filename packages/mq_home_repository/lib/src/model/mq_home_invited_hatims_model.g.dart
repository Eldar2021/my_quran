// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mq_home_invited_hatims_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MqHomeInvitedHatimsModel _$MqHomeInvitedHatimsModelFromJson(Map<String, dynamic> json) => MqHomeInvitedHatimsModel(
  id: json['id'] as String,
  title: json['title'] as String?,
  description: json['description'] as String?,
  type: json['type'] as String,
  status: json['status'] as String,
  creator: json['creator'] == null ? null : MqHatimCreatorModel.fromJson(json['creator'] as Map<String, dynamic>),
  participantsDetails:
      (json['participantsDetails'] as List<dynamic>?)
          ?.map((e) => MqHatimParticipantsDetailModel.fromJson(e as Map<String, dynamic>))
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

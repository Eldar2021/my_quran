// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mq_hatim_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MqHatimsModel _$MqHatimsModelFromJson(Map<String, dynamic> json) => MqHatimsModel(
  id: json['id'] as String,
  title: json['title'] as String?,
  description: json['description'] as String?,
  type: json['type'] as String,
  status: json['status'] as String,
  creator: json['creator'] == null ? null : MqHatimCreatorModel.fromJson(json['creator'] as Map<String, dynamic>),
  participantsDetails:
      (json['participants_details'] as List<dynamic>?)
          ?.map((e) => MqHatimParticipantsDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$MqHatimsModelToJson(MqHatimsModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'type': instance.type,
  'status': instance.status,
  'creator': instance.creator,
  'participants_details': instance.participantsDetails,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mq_hatim_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MqHatimModel _$MqHatimModelFromJson(Map<String, dynamic> json) => MqHatimModel(
  id: json['id'] as String,
  title: json['title'] as String?,
  description: json['description'] as String?,
  type: json['type'] as String,
  status: json['status'] as String,
  creator: json['creator'] == null
      ? null
      : MqHatimCreateUserModel.fromJson(
          json['creator'] as Map<String, dynamic>,
        ),
  participants: (json['participants_details'] as List<dynamic>?)
      ?.map((e) => MqHatimParticipantModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MqHatimModelToJson(MqHatimModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'type': instance.type,
  'status': instance.status,
  'creator': instance.creator,
  'participants_details': instance.participants,
};

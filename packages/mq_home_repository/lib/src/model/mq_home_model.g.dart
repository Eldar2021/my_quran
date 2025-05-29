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
  hatims: (json['hatims'] as List<dynamic>?)?.map((e) => MqHatimsModel.fromJson(e as Map<String, dynamic>)).toList(),
);

Map<String, dynamic> _$MqHomeModelToJson(MqHomeModel instance) => <String, dynamic>{
  'allDoneHatims': instance.allDoneHatims,
  'allDonePages': instance.allDonePages,
  'donePages': instance.donePages,
  'enableCreationHatim': instance.enableCreationHatim,
  'invitedHatims': instance.invitedHatims,
  'hatims': instance.hatims,
};

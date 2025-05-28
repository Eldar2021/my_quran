// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mq_hatim_participants_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MqHatimParticipantsDetailModel _$MqHatimParticipantsDetailModelFromJson(Map<String, dynamic> json) =>
    MqHatimParticipantsDetailModel(
      id: (json['id'] as num).toInt(),
      hatim: json['hatim'] as String,
      user: MqHomeUserModel.fromJson(json['user'] as Map<String, dynamic>),
      accepted: json['accepted'] as bool,
    );

Map<String, dynamic> _$MqHatimParticipantsDetailModelToJson(MqHatimParticipantsDetailModel instance) =>
    <String, dynamic>{'id': instance.id, 'hatim': instance.hatim, 'user': instance.user, 'accepted': instance.accepted};

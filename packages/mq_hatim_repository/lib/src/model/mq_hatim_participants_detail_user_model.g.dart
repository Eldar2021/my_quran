// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mq_hatim_participants_detail_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MqHatimParticipantsDetailUserModel _$MqHatimParticipantsDetailUserModelFromJson(Map<String, dynamic> json) =>
    MqHatimParticipantsDetailUserModel(
      id: (json['id'] as num).toInt(),
      hatim: json['hatim'] as String,
      user: json['user'] == null ? null : MqUserHatimModel.fromJson(json['user'] as Map<String, dynamic>),
      accepted: json['accepted'] as bool,
    );

Map<String, dynamic> _$MqHatimParticipantsDetailUserModelToJson(MqHatimParticipantsDetailUserModel instance) =>
    <String, dynamic>{'id': instance.id, 'hatim': instance.hatim, 'user': instance.user, 'accepted': instance.accepted};

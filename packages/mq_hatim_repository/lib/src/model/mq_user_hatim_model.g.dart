// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mq_user_hatim_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MqUserHatimModel _$MqUserHatimModelFromJson(Map<String, dynamic> json) => MqUserHatimModel(
  id: (json['id'] as num).toInt(),
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  userName: json['username'] as String?,
  email: json['email'] as String?,
  avatar: json['avatar'] as String?,
);

Map<String, dynamic> _$MqUserHatimModelToJson(MqUserHatimModel instance) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'username': instance.userName,
  'email': instance.email,
  'avatar': instance.avatar,
};

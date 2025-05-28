// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mq_hatim_creator_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MqHatimCreatorModel _$MqHatimCreatorModelFromJson(Map<String, dynamic> json) => MqHatimCreatorModel(
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  userName: json['username'] as String,
  email: json['email'] as String,
  avatar: json['avatar'] as String?,
);

Map<String, dynamic> _$MqHatimCreatorModelToJson(MqHatimCreatorModel instance) => <String, dynamic>{
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'username': instance.userName,
  'email': instance.email,
  'avatar': instance.avatar,
};

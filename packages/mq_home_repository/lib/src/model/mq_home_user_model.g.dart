// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mq_home_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

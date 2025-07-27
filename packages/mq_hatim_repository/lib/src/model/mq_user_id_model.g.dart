// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mq_user_id_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MqUserIdModel _$MqUserIdModelFromJson(Map<String, dynamic> json) => MqUserIdModel(
  id: (json['id'] as num?)?.toInt(),
  userName: json['username'] as String?,
  email: json['email'] as String?,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
);

Map<String, dynamic> _$MqUserIdModelToJson(MqUserIdModel instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.userName,
  'email': instance.email,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
};

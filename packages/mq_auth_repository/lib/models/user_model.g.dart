// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  username: json['username'] as String?,
  avatar: json['avatar'] as String?,
  email: json['email'] as String?,
  country: json['country'] as String?,
  phoneNumber: json['phone_number'] as String?,
  gender: _$JsonConverterFromJson<String, Gender>(
    json['gender'],
    const GenderTypeConverter().fromJson,
  ),
  language: json['language'] as String?,
  canCreateHatim: json['can_create_hatim'] as bool?,
  allowNotifications: json['allow_notifications'] as bool?,
  timezone: json['timezone'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'username': instance.username,
  'avatar': instance.avatar,
  'email': instance.email,
  'country': instance.country,
  'phone_number': instance.phoneNumber,
  'gender': _$JsonConverterToJson<String, Gender>(
    instance.gender,
    const GenderTypeConverter().toJson,
  ),
  'language': instance.language,
  'can_create_hatim': instance.canCreateHatim,
  'allow_notifications': instance.allowNotifications,
  'timezone': instance.timezone,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

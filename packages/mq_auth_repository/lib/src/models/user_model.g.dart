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
  gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
  language: json['language'] as String?,
  canCreateHatim: json['can_create_hatim'] as bool?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'username': instance.username,
  'avatar': instance.avatar,
  'email': instance.email,
  'country': instance.country,
  'phone_number': instance.phoneNumber,
  'gender': _$GenderEnumMap[instance.gender],
  'language': instance.language,
  'can_create_hatim': instance.canCreateHatim,
};

const _$GenderEnumMap = {Gender.male: 'male', Gender.female: 'female'};

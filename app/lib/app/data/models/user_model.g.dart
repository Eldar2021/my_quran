// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModelResponse _$UserModelResponseFromJson(Map<String, dynamic> json) => UserModelResponse(
      accessToken: json['accessToken'] as String,
      username: json['username'] as String,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
    );

Map<String, dynamic> _$UserModelResponseToJson(UserModelResponse instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'username': instance.username,
      'gender': _$GenderEnumMap[instance.gender],
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};

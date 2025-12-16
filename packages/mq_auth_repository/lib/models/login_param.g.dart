// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginParam _$LoginParamFromJson(Map<String, dynamic> json) => LoginParam(
  name: json['name'] as String,
  accessToken: json['accessToken'] as String,
  identityToken: json['identityToken'] as String?,
);

Map<String, dynamic> _$LoginParamToJson(LoginParam instance) => <String, dynamic>{
  'name': instance.name,
  'accessToken': instance.accessToken,
  'identityToken': instance.identityToken,
};

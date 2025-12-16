// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$TokenModelFromJson(Map<String, dynamic> json) => LoginModel(
  json['key'] as String,
  UserTokenModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TokenModelToJson(TokenModel instance) => <String, dynamic>{
  'key': instance.key,
  'user': instance.user,
};

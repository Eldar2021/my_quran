// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenModel _$TokenModelFromJson(Map<String, dynamic> json) =>
    TokenModel(json['key'] as String, UserTokenModel.fromJson(json['user'] as Map<String, dynamic>));

Map<String, dynamic> _$TokenModelToJson(TokenModel instance) => <String, dynamic>{
  'key': instance.key,
  'user': instance.user,
};

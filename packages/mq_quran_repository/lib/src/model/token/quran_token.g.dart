// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranToken _$QuranTokenFromJson(Map<String, dynamic> json) => QuranToken(
  accessToken: json['access_token'] as String,
  tokenType: json['token_type'] as String,
  expiresIn: (json['expires_in'] as num).toInt(),
  scope: json['scope'] as String,
);

Map<String, dynamic> _$QuranTokenToJson(QuranToken instance) => <String, dynamic>{
  'access_token': instance.accessToken,
  'token_type': instance.tokenType,
  'expires_in': instance.expiresIn,
  'scope': instance.scope,
};

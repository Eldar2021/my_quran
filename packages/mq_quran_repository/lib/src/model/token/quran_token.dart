import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quran_token.g.dart';

@JsonSerializable()
@immutable
final class QuranToken {
  const QuranToken({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.scope,
  });

  factory QuranToken.fromJson(Map<String, dynamic> json) => _$QuranTokenFromJson(json);
  Map<String, dynamic> toJson() => _$QuranTokenToJson(this);

  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'token_type')
  final String tokenType;

  @JsonKey(name: 'expires_in')
  final int expiresIn;

  @JsonKey(name: 'scope')
  final String scope;
}

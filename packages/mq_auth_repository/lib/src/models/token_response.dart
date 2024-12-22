import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable()
@immutable
final class TokenResponse {
  const TokenResponse(this.key);

  factory TokenResponse.fromJson(Map<String, dynamic> json) => _$TokenResponseFromJson(json);

  final String key;

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}

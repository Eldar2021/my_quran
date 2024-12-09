import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'package:mq_auth_repository/mq_auth_repository.dart';

part 'user_model.g.dart';

@JsonSerializable()
@immutable
final class UserModelResponse {
  const UserModelResponse({
    required this.accessToken,
    required this.username,
    required this.gender,
    required this.localeCode,
  });

  factory UserModelResponse.fromJson(Map<String, dynamic> json) => _$UserModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelResponseToJson(this);

  final String accessToken;
  final String username;
  final Gender gender;
  final String localeCode;

  UserModelResponse copyWith({
    String? accessToken,
    String? username,
    Gender? gender,
    String? localeCode,
  }) {
    return UserModelResponse(
      accessToken: accessToken ?? this.accessToken,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      localeCode: localeCode ?? this.localeCode,
    );
  }
}

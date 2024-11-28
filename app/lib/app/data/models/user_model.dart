import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';

part 'user_model.g.dart';

@JsonSerializable()
@immutable
final class UserModelResponse {
  const UserModelResponse({
    required this.accessToken,
    required this.username,
    required this.gender,
    required this.localeCode,
    this.identityToken,
  });

  factory UserModelResponse.fromJson(Map<String, dynamic> json) => _$UserModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelResponseToJson(this);

  final String accessToken;
  final String username;
  final Gender gender;
  final String localeCode;
  final String? identityToken;

  UserModelResponse copyWith({
    String? accessToken,
    String? username,
    Gender? gender,
    String? localeCode,
    String? identityToken,
  }) {
    return UserModelResponse(
      accessToken: accessToken ?? this.accessToken,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      localeCode: localeCode ?? this.localeCode,
      identityToken: identityToken ?? this.identityToken,
    );
  }
}

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
    this.gender,
  });

  factory UserModelResponse.fromJson(Map<String, dynamic> json) => _$UserModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelResponseToJson(this);

  final String accessToken;
  final String username;
  final Gender? gender;

  UserModelResponse copyWith({String? accessToken, String? username, Gender? gender}) {
    return UserModelResponse(
      accessToken: accessToken ?? this.accessToken,
      username: username ?? this.username,
      gender: gender ?? this.gender,
    );
  }
}

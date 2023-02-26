import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  const User({
    required this.accessToken,
    required this.username,
    this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  final String accessToken;
  final String username;
  final Gender? gender;

  User copyWith({String? accessToken, String? username, Gender? gender}) {
    return User(
      accessToken: accessToken ?? this.accessToken,
      username: username ?? this.username,
      gender: gender ?? this.gender,
    );
  }
}

enum Gender { male, female }

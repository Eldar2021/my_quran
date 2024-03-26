import 'package:meta/meta.dart';

@immutable
final class UserEntity {
  const UserEntity({
    required this.accessToken,
    required this.username,
    this.gender,
  });

  final String accessToken;
  final String username;
  final Gender? gender;

  UserEntity copyWith({
    String? accessToken,
    String? username,
    Gender? gender,
  }) {
    return UserEntity(
      accessToken: accessToken ?? this.accessToken,
      username: username ?? this.username,
      gender: gender ?? this.gender,
    );
  }
}

enum Gender { male, female }

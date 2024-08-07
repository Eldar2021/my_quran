import 'package:meta/meta.dart';

@immutable
final class UserEntity {
  const UserEntity({
    required this.accessToken,
    required this.username,
    required this.gender,
    required this.localeCode,
  });

  final String accessToken;
  final String username;
  final Gender gender;
  final String localeCode;

  UserEntity copyWith({
    String? accessToken,
    String? username,
    Gender? gender,
    String? localeCode,
  }) {
    return UserEntity(
      accessToken: accessToken ?? this.accessToken,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      localeCode: localeCode ?? this.localeCode,
    );
  }
}

enum Gender {
  male,
  female;

  factory Gender.fromData(String? src) {
    return switch (src) {
      'male' => Gender.male,
      'female' => Gender.female,
      _ => Gender.male,
    };
  }
}

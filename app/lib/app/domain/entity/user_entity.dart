import 'package:meta/meta.dart';

@immutable
final class UserEntity {
  const UserEntity({
    required this.accessToken,
    required this.username,
    required this.gender,
    required this.localeCode,
    this.identityToken,
  });

  final String accessToken;
  final String username;
  final Gender gender;
  final String localeCode;
  final String? identityToken;

  UserEntity copyWith({
    String? accessToken,
    String? username,
    Gender? gender,
    String? localeCode,
    String? identityToken,
  }) {
    return UserEntity(
      accessToken: accessToken ?? this.accessToken,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      localeCode: localeCode ?? this.localeCode,
      identityToken: identityToken ?? this.identityToken,
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

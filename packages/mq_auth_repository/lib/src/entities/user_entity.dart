import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

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

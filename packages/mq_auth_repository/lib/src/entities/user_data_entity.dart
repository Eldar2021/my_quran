import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

@immutable
final class UserDataEntity {
  const UserDataEntity({required this.gender, required this.language});

  final String gender;
  final String language;

  Gender get genderValue => Gender.fromData(gender.toLowerCase());

  String get localeValue => language.toLowerCase();
}

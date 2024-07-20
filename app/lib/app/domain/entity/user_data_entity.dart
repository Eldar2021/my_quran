import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class UserDataEntity {
  const UserDataEntity({
    required this.gender,
    required this.language,
  });

  final String gender;
  final String language;

  Gender get genderValue => Gender.fromData(gender.toLowerCase());

  String get localeValue => language.toLowerCase();
}

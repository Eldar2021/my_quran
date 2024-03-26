import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';

abstract class AuthRepository {
  UserEntity? get init;
  Future<Either<UserEntity, Exception>> login(String languageCode, Gender gender);
  Future<void> saveGender(Gender gender);
}

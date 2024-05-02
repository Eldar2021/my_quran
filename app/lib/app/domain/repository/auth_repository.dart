import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';

abstract class AuthRepository {
  UserEntity? get init;
  Future<Either<UserEntity, Exception>> signWithGoogle();
  Future<void> saveGender(Gender gender);
}

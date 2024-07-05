import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';

abstract class AuthRepository {
  UserEntity? get init;

  Future<Either<UserEntity, Exception>> signUpWithEmail(
    String email,
    String password,
    String languageCode,
    Gender gender,
  );

  Future<Either<UserEntity, Exception>> signInWithEmail(
    String email,
    String password,
    String languageCode,
    Gender gender,
  );

  Future<Either<UserEntity, Exception>> signWithGoogle(
    String languageCode,
    Gender gender,
  );

  Future<Either<UserEntity, Exception>> signWithApple(
    String languageCode,
    Gender gender,
  );

  Future<void> setUserData(UserEntity userEntity);

  Future<Either<UserDataEntity, Exception>> patchGender({
    required String userId,
    required Gender gender,
  });

  Future<Either<UserDataEntity, Exception>> patchLocaleCode({
    required String userId,
    required String localeCode,
  });

  Future<void> forgotPassword(String email);

  Future<void> logout() async {}
}

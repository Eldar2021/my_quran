import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';

abstract class AuthRepository {
  UserEntity? get init;

  Future<Either<UserEntity, Exception>> signUpWithEmail({
    required String email,
    required String password,
    required String username,
    required String languageCode,
    required Gender gender,
  });

  Future<Either<UserEntity, Exception>> signInWithEmail({
    required String email,
    required String password,
    required String languageCode,
    required Gender gender,
  });

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

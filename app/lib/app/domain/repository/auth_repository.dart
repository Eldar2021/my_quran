import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';

abstract class AuthRepository {
  UserEntity? get init;

  Future<void> loginWithEmail(String email);

  Future<Either<UserEntity, Exception>> fetchSmsCode({
    required String code,
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

  Future<void> logout() async {}
}

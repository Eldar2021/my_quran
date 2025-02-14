import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_either/mq_either.dart';

abstract class AuthRepository {
  UserEntity? get init;

  Future<void> loginWithEmail(String email);

  Future<Either<UserEntity, Exception>> verifyOtp({
    required String email,
    required String otp,
    required String languageCode,
    required Gender gender,
  });
  Future<Either<UserEntity, Exception>> signWithGoogle(String languageCode, Gender gender);

  Future<Either<UserEntity, Exception>> signWithApple(String languageCode, Gender gender);

  Future<void> setUserData(UserEntity userEntity);

  Future<Either<UserDataEntity, Exception>> patchGender({required String userId, required Gender gender});

  Future<Either<UserDataEntity, Exception>> patchLocaleCode({required String userId, required String localeCode});

  Future<void> deleteAccount();

  Future<void> logout();
}

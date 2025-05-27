import 'package:mq_auth_repository/mq_auth_repository.dart';

abstract class AuthRepository {
  UserEntity? get init;

  Future<void> loginWithEmail(String email);

  Future<UserEntity> verifyOtp({
    required String email,
    required String otp,
    required String languageCode,
    required Gender gender,
  });
  Future<UserEntity> signWithGoogle(String languageCode, Gender gender);

  Future<UserEntity> signWithApple(String languageCode, Gender gender);

  Future<void> setUserData(UserEntity userEntity);

  Future<UserDataEntity> patchGender({required String userId, required Gender gender});

  Future<UserDataEntity> patchLocaleCode({required String userId, required String localeCode});

  Future<void> deleteAccount();

  Future<void> logout();
}

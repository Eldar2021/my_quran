import 'package:mq_auth_repository/mq_auth_repository.dart';

abstract class AuthRepository {
  UserModelResponse? get init;

  Future<void> loginWithEmail(String email);

  Future<UserModelResponse> verifyOtp({
    required String email,
    required String otp,
    required String languageCode,
    required Gender gender,
  });

  Future<UserModelResponse> signWithGoogle(
    String languageCode,
    Gender gender,
  );

  Future<UserModelResponse> signWithApple(
    String languageCode,
    Gender gender,
  );

  Future<void> setUserData(
    UserModelResponse userEntity,
  );

  Future<UserModelResponse> patchGender({
    required String userId,
    required Gender gender,
  });

  Future<UserModelResponse> patchLocaleCode({
    required String userId,
    required String localeCode,
  });

  Future<void> deleteAccount();

  Future<void> logout();
}

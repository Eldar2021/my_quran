import 'package:mq_auth_repository/mq_auth_repository.dart';

abstract class AuthRepository {
  UserModel? get init;

  Future<void> loginWithEmail(String email);

  Future<LoginModel> verifyOtp({
    required String email,
    required String otp,
    required String languageCode,
    required Gender gender,
  });

  Future<LoginModel> signWithGoogle(
    String languageCode,
    Gender gender,
  );

  Future<LoginModel> signWithApple(
    String languageCode,
    Gender gender,
  );

  Future<void> setUserData(
    UserModel userEntity,
  );

  Future<UserModel> patchGender({
    required String userId,
    required Gender gender,
  });

  Future<UserModel> patchLocaleCode({
    required String userId,
    required String localeCode,
  });

  Future<void> deleteAccount();

  Future<void> logout();
}

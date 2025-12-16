import 'package:mq_auth_repository/mq_auth_repository.dart';

abstract class AuthRemoteDataSource {
  Future<void> loginWithEmail(String email);

  Future<AuthModel> verifyOtp({
    required String email,
    required String otp,
    required String languageCode,
    required Gender gender,
  });

  Future<AuthModel> signInWithGoogle(
    String languageCode,
    Gender gender,
  );

  Future<AuthModel> signInWithApple(
    String languageCode,
    Gender gender,
  );

  Future<UserModel> saveUserData(
    UserModel userModel,
  );

  Future<UserModel> pathGender({
    required String userId,
    required Gender gender,
  });

  Future<UserModel> pathLocaleCode({
    required String userId,
    required String localeCode,
  });

  Future<void> deleteAccountRemote();

  Future<void> logoutRemote();
}

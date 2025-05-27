import 'package:mq_auth_repository/mq_auth_repository.dart';

abstract class AuthRemoteDataSource {
  Future<void> loginWithEmail(String email);

  Future<UserModelResponse> verifyOtp({
    required String email,
    required String otp,
    required String languageCode,
    required Gender gender,
  });

  Future<UserModelResponse> signInWithGoogle(String languageCode, Gender gender);

  Future<UserModelResponse> signInWithApple(String languageCode, Gender gender);

  Future<UserDataResponse> saveUserData(UserModelResponse userModel);

  Future<UserDataResponse> pathGender({required String userId, required Gender gender});

  Future<UserDataResponse> pathLocaleCode({required String userId, required String localeCode});

  Future<void> deleteAccountRemote();

  Future<void> logoutRemote();
}

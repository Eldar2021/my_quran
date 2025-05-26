import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

@immutable
final class AuthRemoteDataSourceMock implements AuthRemoteDataSource {
  const AuthRemoteDataSourceMock();

  @override
  Future<void> loginWithEmail(String email) => Future.value();

  @override
  Future<UserModelResponse> verifyOtp({
    required String email,
    required String otp,
    required String languageCode,
    required Gender gender,
  }) async {
    return UserModelResponse(
      accessToken: r'myquran_te$t_t0ken',
      username: 'Test User',
      gender: gender,
      localeCode: languageCode,
    );
  }

  @override
  Future<UserModelResponse> signInWithGoogle(String languageCode, Gender gender) async {
    return UserModelResponse(
      accessToken: 'mock_token_google',
      username: 'Mock Google User',
      gender: gender,
      localeCode: languageCode,
    );
  }

  @override
  Future<UserModelResponse> signInWithApple(String languageCode, Gender gender) async {
    return UserModelResponse(
      accessToken: 'mock_token_apple',
      username: 'Mock Apple User',
      gender: gender,
      localeCode: languageCode,
    );
  }

  @override
  Future<UserDataResponse> saveUserData(UserEntity userEntity) async {
    return UserDataResponse(gender: userEntity.gender.toString(), language: userEntity.localeCode);
  }

  @override
  Future<UserDataResponse> pathGender({required String userId, required Gender gender}) async {
    return UserDataResponse(gender: Gender.male.toString(), language: 'en');
  }

  @override
  Future<UserDataResponse> pathLocaleCode({required String userId, required String localeCode}) async {
    return UserDataResponse(gender: Gender.male.toString(), language: 'en');
  }

  @override
  Future<void> deleteAccountRemote() => Future.value();

  @override
  Future<void> logoutRemote() => Future.value();
}

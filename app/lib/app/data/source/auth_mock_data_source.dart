import 'package:meta/meta.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/constants/contants.dart';

import 'package:my_quran/core/core.dart';

@immutable
final class AuthMockDataSource implements AuthDataSource {
  const AuthMockDataSource(this.storage);
  final PreferencesStorage storage;

  @override
  Future<void> loginWithEmail(String email) async {
    return;
  }

  @override
  Future<Either<UserModelResponse, Exception>> fetchSmsCode({
    required String code,
    required String languageCode,
    required Gender gender,
  }) async {
    final user = UserModelResponse(
      accessToken: r'myquran_te$t_t0ken',
      username: 'Test User',
      gender: gender,
      localeCode: languageCode,
    );
    await storage.writeString(key: StorageKeys.tokenKey, value: user.accessToken);
    await storage.writeString(key: StorageKeys.usernameKey, value: user.username);

    return Right(user);
  }

  @override
  Future<Either<UserModelResponse, Exception>> signInWithGoogle(
    String languageCode,
    Gender gender,
  ) async {
    final user = UserModelResponse(
      accessToken: 'mock_token_google',
      username: 'Mock Google User',
      gender: gender,
      localeCode: languageCode,
    );
    return Right(user);
  }

  @override
  Future<Either<UserModelResponse, Exception>> signInWithApple(
    String languageCode,
    Gender gender,
  ) async {
    final user = UserModelResponse(
      accessToken: 'mock_token_apple',
      username: 'Mock Apple User',
      gender: gender,
      localeCode: languageCode,
    );
    return Right(user);
  }

  @override
  Future<Either<UserDataResponse, Exception>> saveUserData(UserEntity userEntity) async {
    final response = UserDataResponse(
      gender: userEntity.gender.toString(),
      language: userEntity.localeCode,
    );
    return Right(response);
  }

  @override
  Future<Either<UserDataResponse, Exception>> pathGender({
    required String userId,
    required Gender gender,
  }) async {
    final response = UserDataResponse(
      gender: Gender.male.toString(),
      language: 'en',
    );
    return Right(response);
  }

  @override
  Future<Either<UserDataResponse, Exception>> pathLocaleCode({
    required String userId,
    required String localeCode,
  }) async {
    final response = UserDataResponse(
      gender: Gender.male.toString(),
      language: 'en',
    );
    return Right(response);
  }

  @override
  Future<void> logoutRemote() async {
    return;
  }
}

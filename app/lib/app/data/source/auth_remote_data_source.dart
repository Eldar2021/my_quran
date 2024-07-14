import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';

@immutable
final class AuthRemoteDataSource {
  const AuthRemoteDataSource({
    required this.client,
    required this.storage,
    required this.soccialAuth,
    required this.isIntegrationTest,
  });

  final MqDio client;
  final PreferencesStorage storage;
  final SoccialAuth soccialAuth;
  final bool isIntegrationTest;

  Future<void> loginWithEmail(String email) async {
    try {
      await client.post(
        apiConst.loginWithEmail,
        fromJson: TokenResponse.fromJson,
        body: {'email': email},
      );
    } catch (e) {
      Exception('Error during login: $e');
    }
  }

  Future<Either<UserModelResponse, Exception>> fetchSmsCode({
    required String code,
    required String languageCode,
    required Gender gender,
  }) async {
    try {
      final token = await client.post(
        apiConst.fetchSmsCode,
        fromJson: TokenResponse.fromJson,
        body: {'email': 'john@mail.com', 'password': 'changeme'},
      );
      log(token.toString());
      return token.fold(
        (error) {
          log('Login error: $error');
          return Left(error);
        },
        (r) async {
          final user = UserModelResponse(
            accessToken: r.key,
            username: '',
            gender: gender,
            localeCode: languageCode,
          );

          await storage.writeString(key: StorageKeys.tokenKey, value: user.accessToken);

          return Right(user);
        },
      );
    } catch (e) {
      return Left(Exception('Error fetching SMS code: $e'));
    }
  }

  Future<Either<UserModelResponse, Exception>> signInWithGoogle(
    String languageCode,
    Gender gender,
  ) async {
    final googleAuth = await _getGoogleAuth();

    final token = await client.postType(
      apiConst.loginWithGoogle,
      fromJson: TokenResponse.fromJson,
      body: {'access_token': googleAuth.accessToken},
    );

    return token.fold(Left.new, (r) async {
      final user = UserModelResponse(
        accessToken: r.key,
        username: googleAuth.name,
        gender: gender,
        localeCode: languageCode,
      );

      await storage.writeString(key: StorageKeys.tokenKey, value: user.accessToken);

      return Right(user);
    });
  }

  Future<_UserReqParam> _getGoogleAuth() async {
    if (isIntegrationTest) {
      return const _UserReqParam(
        name: 'Test User',
        accessToken: r'myquran_te$t_t0ken',
      );
    } else {
      final googleAuth = await soccialAuth.signInWithGoogle();
      final accessToken = googleAuth.credential?.accessToken ?? '';
      final username = googleAuth.user?.displayName ?? '';
      return _UserReqParam(
        name: username,
        accessToken: accessToken,
      );
    }
  }

  Future<Either<UserModelResponse, Exception>> signInWithApple(
    String languageCode,
    Gender gender,
  ) async {
    final appleAuth = await _getAppleAuth();

    final token = await client.postType(
      apiConst.loginWithApple,
      fromJson: TokenResponse.fromJson,
      body: {'access_token': appleAuth.accessToken},
    );

    return token.fold(Left.new, (r) async {
      final user = UserModelResponse(
        accessToken: r.key,
        username: appleAuth.name,
        gender: gender,
        localeCode: languageCode,
      );

      await storage.writeString(key: StorageKeys.tokenKey, value: user.accessToken);

      return Right(user);
    });
  }

  Future<_UserReqParam> _getAppleAuth() async {
    if (isIntegrationTest) {
      return const _UserReqParam(
        name: 'Test User',
        accessToken: r'myquran_te$t_t0ken',
      );
    } else {
      final appleAuth = await soccialAuth.signInWithApple();
      final accessToken = appleAuth.credential?.accessToken ?? '';
      final username = appleAuth.user?.displayName ?? '';
      return _UserReqParam(
        name: username,
        accessToken: accessToken,
      );
    }
  }

  Future<Either<UserDataResponse, Exception>> saveUserData(UserEntity userEntity) {
    return client.putType(
      apiConst.putProfile(userEntity.accessToken),
      fromJson: UserDataResponse.fromJson,
      body: {
        'gender': userEntity.gender.name.toUpperCase(),
        'language': userEntity.localeCode.toUpperCase(),
      },
    );
  }

  Future<Either<UserDataResponse, Exception>> pathGender({
    required String userId,
    required Gender gender,
  }) {


    return client.patchType(

      apiConst.putProfile(userId),
      fromJson: UserDataResponse.fromJson,
      body: {'gender': gender.name.toUpperCase()},
    );
  }

  Future<Either<UserDataResponse, Exception>> pathLocaleCode({
    required String userId,
    required String localeCode,
  }) {
    return client.patchType(
      apiConst.putProfile(userId),
      fromJson: UserDataResponse.fromJson,
      body: {'language': localeCode.toUpperCase()},
    );
  }

  Future<void> logoutRemote() async {
    await soccialAuth.logOut();
  }
}

@immutable
final class _UserReqParam {
  const _UserReqParam({
    required this.name,
    required this.accessToken,
  });

  final String name;
  final String accessToken;
}

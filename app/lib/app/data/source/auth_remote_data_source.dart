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

  final RemoteClient client;
  final PreferencesStorage storage;
  final SoccialAuth soccialAuth;
  final bool isIntegrationTest;

  Future<Either<UserModelResponse, Exception>> signInWithGoogle(
    String languageCode,
    Gender gender,
  ) async {
    final googleAuth = await _getGoogleAuth();

    final token = await client.post(
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

    final token = await client.post(
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
    return client.put(
      apiConst.putProfile(userEntity.accessToken),
      fromJson: UserDataResponse.fromJson,
      body: {
        'gender': userEntity.gender.name.toUpperCase(),
        'language': userEntity.localeCode.toUpperCase(),
      },
      token: userEntity.accessToken,
    );
  }

  Future<Either<UserDataResponse, Exception>> pathGender({
    required String userId,
    required Gender gender,
  }) {
    return client.patch(
      apiConst.putProfile(userId),
      fromJson: UserDataResponse.fromJson,
      body: {'gender': gender.name.toUpperCase()},
      token: userId,
    );
  }

  Future<Either<UserDataResponse, Exception>> pathLocaleCode({
    required String userId,
    required String localeCode,
  }) {
    return client.patch(
      apiConst.putProfile(userId),
      fromJson: UserDataResponse.fromJson,
      body: {'language': localeCode.toUpperCase()},
      token: userId,
    );
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

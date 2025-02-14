import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_either/mq_either.dart';
import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:mq_storage/mq_storage.dart';

@immutable
final class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({
    required this.client,
    required this.storage,
    required this.soccialAuth,
    required this.isIntegrationTest,
  });

  final MqRemoteClient client;
  final PreferencesStorage storage;
  final SoccialAuth soccialAuth;
  final bool isIntegrationTest;

  @override
  Future<Either<UserModelResponse, Exception>> verifyOtp({
    required String otp,
    required String email,
    required String languageCode,
    required Gender gender,
  }) async {
    try {
      final token = await client.postType(
        '/api/v1/accounts/otp/verify/',
        fromJson: TokenResponse.fromJson,
        body: {'email': email, 'opt': otp},
      );

      return token.fold(Left.new, (r) async {
        final user = UserModelResponse(accessToken: r.key, username: email, gender: gender, localeCode: languageCode);

        await storage.writeString(key: MqAuthStatics.tokenKey, value: user.accessToken);

        return Right(user);
      });
    } on Exception catch (e) {
      return Left(Exception('Error fetching SMS code: $e'));
    }
  }

  @override
  Future<void> loginWithEmail(String email) async {
    try {
      await client.postType('/api/v1/accounts/otp/send/', fromJson: Map<String, dynamic>.from, body: {'email': email});
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }

  @override
  Future<Either<UserModelResponse, Exception>> signInWithGoogle(String languageCode, Gender gender) async {
    final googleAuth = await _getGoogleAuth();

    final token = await client.postType(
      '/api/v1/accounts/google/',
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

      await storage.writeString(key: MqAuthStatics.tokenKey, value: user.accessToken);

      return Right(user);
    });
  }

  Future<_UserReqParam> _getGoogleAuth() async {
    if (isIntegrationTest) {
      return const _UserReqParam(name: 'Test User', accessToken: r'myquran_te$t_t0ken');
    } else {
      final googleAuth = await soccialAuth.signInWithGoogle();
      final accessToken = googleAuth?['accessToken'] ?? '';
      final username = googleAuth?['name'] ?? '';
      return _UserReqParam(name: username.toString(), accessToken: accessToken.toString());
    }
  }

  @override
  Future<Either<UserModelResponse, Exception>> signInWithApple(String languageCode, Gender gender) async {
    final appleAuth = await _getAppleAuth();

    final token = await client.postType(
      '/api/v1/accounts/apple/',
      fromJson: TokenResponse.fromJson,
      body: {'access_token': appleAuth.accessToken, 'id_token': appleAuth.identityToken},
    );

    return token.fold(Left.new, (r) async {
      final user = UserModelResponse(
        accessToken: r.key,
        username: appleAuth.name,
        gender: gender,
        localeCode: languageCode,
      );

      await storage.writeString(key: MqAuthStatics.tokenKey, value: user.accessToken);

      return Right(user);
    });
  }

  Future<_UserReqParam> _getAppleAuth() async {
    if (isIntegrationTest) {
      return const _UserReqParam(name: 'Test User', accessToken: r'myquran_te$t_t0ken');
    } else {
      final appleAuth = await soccialAuth.signInWithApple();
      final identityToken = appleAuth.$2.identityToken ?? '';
      final accessToken = appleAuth.$1.credential!.accessToken ?? '';
      final username = appleAuth.$1.user?.displayName ?? '';

      return _UserReqParam(name: username, accessToken: accessToken, identityToken: identityToken);
    }
  }

  @override
  Future<Either<UserDataResponse, Exception>> saveUserData(UserEntity userEntity) {
    return client.putType(
      '/api/v1/accounts/profile/${userEntity.accessToken}/',
      fromJson: UserDataResponse.fromJson,
      body: {'gender': userEntity.gender.name.toUpperCase(), 'language': userEntity.localeCode.toUpperCase()},
    );
  }

  @override
  Future<Either<UserDataResponse, Exception>> pathGender({required String userId, required Gender gender}) {
    return client.patchType(
      '/api/v1/accounts/profile/$userId/',
      fromJson: UserDataResponse.fromJson,
      body: {'gender': gender.name.toUpperCase()},
    );
  }

  @override
  Future<Either<UserDataResponse, Exception>> pathLocaleCode({required String userId, required String localeCode}) {
    return client.patchType(
      '/api/v1/accounts/profile/$userId/',
      fromJson: UserDataResponse.fromJson,
      body: {'language': localeCode.toUpperCase()},
    );
  }

  @override
  Future<void> deleteAccountRemote() async {
    await client.delete<Map<String, dynamic>>('/api/v1/accounts/profile/delete_my_account/');

    await soccialAuth.deleteAccount();
  }

  @override
  Future<void> logoutRemote() async {
    await soccialAuth.logOut();
  }
}

@immutable
final class _UserReqParam {
  const _UserReqParam({required this.name, required this.accessToken, this.identityToken});

  final String name;
  final String accessToken;
  final String? identityToken;
}

import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
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
  Future<UserModelResponse> verifyOtp({
    required String otp,
    required String email,
    required String languageCode,
    required Gender gender,
  }) async {
    final token = await client.postType(
      '/api/v1/accounts/otp/verify/',
      fromJson: TokenModel.fromJson,
      body: {'email': email, 'opt': otp},
    );

    final user = UserModelResponse(accessToken: token.key, username: email, gender: gender, localeCode: languageCode);

    await storage.writeString(key: MqAuthStatics.tokenKey, value: user.accessToken);

    return user;
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
  Future<UserModelResponse> signInWithGoogle(String languageCode, Gender gender) async {
    final googleAuth = await _getGoogleAuth();

    final token = await client.postType(
      '/api/v1/accounts/google/',
      fromJson: TokenModel.fromJson,
      body: {'access_token': googleAuth.accessToken, 'gender': gender.name, 'language': languageCode},
    );

    final user = UserModelResponse(
      accessToken: token.key,
      username: googleAuth.name,
      gender: gender,
      localeCode: languageCode,
    );

    await storage.writeString(key: MqAuthStatics.tokenKey, value: user.accessToken);

    return user;
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
  Future<UserModelResponse> signInWithApple(String languageCode, Gender gender) async {
    final appleAuth = await _getAppleAuth();

    final token = await client.postType(
      '/api/v1/accounts/apple/',
      fromJson: TokenModel.fromJson,
      body: {
        'access_token': appleAuth.accessToken,
        'id_token': appleAuth.identityToken,
        'gender': gender.name,
        'language': languageCode,
      },
    );

    final user = UserModelResponse(
      accessToken: token.key,
      username: appleAuth.name,
      gender: gender,
      localeCode: languageCode,
    );

    await storage.writeString(key: MqAuthStatics.tokenKey, value: user.accessToken);

    return user;
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
  Future<UserDataResponse> saveUserData(UserModelResponse userModel) {
    return client.putType(
      '/api/v1/accounts/profile/${userModel.accessToken}/',
      fromJson: UserDataResponse.fromJson,
      body: {'gender': userModel.gender.name.toUpperCase(), 'language': userModel.localeCode.toUpperCase()},
    );
  }

  @override
  Future<UserDataResponse> pathGender({required String userId, required Gender gender}) {
    return client.patchType(
      '/api/v1/accounts/profile/$userId/',
      fromJson: UserDataResponse.fromJson,
      body: {'gender': gender.name.toUpperCase()},
    );
  }

  @override
  Future<UserDataResponse> pathLocaleCode({required String userId, required String localeCode}) {
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

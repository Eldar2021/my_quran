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
  Future<LoginModel> verifyOtp({
    required String otp,
    required String email,
    required String languageCode,
    required Gender gender,
  }) async {
    final token = await client.postType(
      '/api/v1/accounts/otp/verify/',
      fromJson: LoginModel.fromJson,
      body: {'email': email, 'opt': otp},
    );

    await storage.writeString(
      key: MqAuthStatics.tokenKey,
      value: token.key,
    );

    return token;
  }

  @override
  Future<void> loginWithEmail(String email) async {
    try {
      await client.postType(
        '/api/v1/accounts/otp/send/',
        fromJson: Map<String, dynamic>.from,
        body: {'email': email},
      );
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }

  @override
  Future<LoginModel> signInWithGoogle(
    String languageCode,
    Gender gender,
  ) async {
    final googleAuth = await _getGoogleAuth();

    final token = await client.postType(
      '/api/v1/accounts/google/',
      fromJson: LoginModel.fromJson,
      body: {
        'access_token': googleAuth.accessToken,
        'gender': gender.name,
        'language': languageCode,
      },
    );

    await storage.writeString(
      key: MqAuthStatics.tokenKey,
      value: token.key,
    );

    return token;
  }

  Future<_UserReqParam> _getGoogleAuth() async {
    if (isIntegrationTest) {
      return const _UserReqParam(
        name: 'Test User',
        accessToken: r'myquran_te$t_t0ken',
      );
    } else {
      final googleAuth = await soccialAuth.signInWithGoogle();
      final accessToken = googleAuth?['accessToken'] ?? '';
      final username = googleAuth?['name'] ?? '';

      return _UserReqParam(
        name: username.toString(),
        accessToken: accessToken.toString(),
      );
    }
  }

  @override
  Future<LoginModel> signInWithApple(
    String languageCode,
    Gender gender,
  ) async {
    final appleAuth = await _getAppleAuth();

    final token = await client.postType(
      '/api/v1/accounts/apple/',
      fromJson: LoginModel.fromJson,
      body: {
        'access_token': appleAuth.accessToken,
        'id_token': appleAuth.identityToken,
        'gender': gender.name,
        'language': languageCode,
      },
    );

    await storage.writeString(
      key: MqAuthStatics.tokenKey,
      value: token.key,
    );

    return token;
  }

  Future<_UserReqParam> _getAppleAuth() async {
    if (isIntegrationTest) {
      return const _UserReqParam(
        name: 'Test User',
        accessToken: r'myquran_te$t_t0ken',
      );
    } else {
      final appleAuth = await soccialAuth.signInWithApple();
      final identityToken = appleAuth.$2.identityToken ?? '';
      final accessToken = appleAuth.$1.credential!.accessToken ?? '';
      final username = appleAuth.$1.user?.displayName ?? '';

      return _UserReqParam(
        name: username,
        accessToken: accessToken,
        identityToken: identityToken,
      );
    }
  }

  @override
  Future<UserTokenModel> saveUserData(UserTokenModel userModel) {
    return client.putType(
      '/api/v1/accounts/profile/${userModel.firstName}/',
      fromJson: UserTokenModel.fromJson,
      body: {
        'gender': userModel.gender?.name.toUpperCase() ?? 'MALE',
        'language': userModel.language?.toUpperCase() ?? 'EN',
      },
    );
  }

  @override
  Future<UserTokenModel> pathGender({
    required String userId,
    required Gender gender,
  }) {
    return client.patchType(
      '/api/v1/accounts/profile/$userId/',
      fromJson: UserTokenModel.fromJson,
      body: {'gender': gender.name.toUpperCase()},
    );
  }

  @override
  Future<UserTokenModel> pathLocaleCode({
    required String userId,
    required String localeCode,
  }) {
    return client.patchType(
      '/api/v1/accounts/profile/$userId/',
      fromJson: UserTokenModel.fromJson,
      body: {'language': localeCode.toUpperCase()},
    );
  }

  @override
  Future<void> deleteAccountRemote() async {
    await client.delete<Map<String, dynamic>>(
      '/api/v1/accounts/profile/delete_my_account/',
    );

    await soccialAuth.deleteAccount();
  }

  @override
  Future<void> logoutRemote() async {
    await soccialAuth.logOut();
  }
}

@immutable
final class _UserReqParam {
  const _UserReqParam({
    required this.name,
    required this.accessToken,
    this.identityToken,
  });

  final String name;
  final String accessToken;
  final String? identityToken;
}

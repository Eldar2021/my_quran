import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:mq_either/mq_either.dart';
import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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
        apiConst.loginEmailVerify,
        fromJson: TokenResponse.fromJson,
        body: {'email': email, 'opt': otp},
      );

      return token.fold(
        (error) {
          return Left(error);
        },
        (r) async {
          final user = UserModelResponse(
            accessToken: r.key,
            username: email,
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

  @override
  Future<void> loginWithEmail(String email) async {
    try {
      await client.postType(
        apiConst.loginEmailSend,
        fromJson: Map<String, dynamic>.from,
        body: {'email': email},
      );
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }

  @override
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
      final accessToken = googleAuth?['accessToken'] ?? '';
      final username = googleAuth?['name'] ?? '';
      return _UserReqParam(
        name: username.toString(),
        accessToken: accessToken.toString(),
      );
    }
  }

  @override
  Future<Either<UserModelResponse, Exception>> signInWithApple(
    String languageCode,
    Gender gender,
  ) async {
    final appleAuth = await _getAppleAuth();

    final token = await client.postType(
      apiConst.loginWithApple,
      fromJson: TokenResponse.fromJson,
      body: {
        'access_token': appleAuth.$1.accessToken,
        'id_token': appleAuth.$1.identityToken,
      },
    );
    return token.fold((l) {
      log('Error occurred: ${l.message}');
      final exc = AppleSignInExc(
        userCredential: appleAuth.$2,
        authorizationCredentialAppleID: appleAuth.$3,
        exc: l,
      );

      return Left(exc);
    }, (r) async {
      final user = UserModelResponse(
        accessToken: r.key,
        username: appleAuth.$1.name,
        gender: gender,
        localeCode: languageCode,
      );

      await storage.writeString(key: StorageKeys.tokenKey, value: user.accessToken);

      return Right(user);
    });
  }

  Future<(_UserReqParam, UserCredential?, AuthorizationCredentialAppleID?)> _getAppleAuth() async {
    if (isIntegrationTest) {
      return (
        const _UserReqParam(
          name: 'Test User',
          accessToken: r'myquran_te$t_t0ken',
        ),
        null,
        null,
      );
    } else {
      final appleAuth = await soccialAuth.signInWithApple();
      final identityToken = appleAuth.$2.identityToken ?? '';
      final accessToken = appleAuth.$1.credential!.accessToken ?? '';
      final username = appleAuth.$1.user?.displayName ?? '';

      return (
        _UserReqParam(
          name: username,
          accessToken: accessToken,
          identityToken: identityToken,
        ),
        appleAuth.$1,
        appleAuth.$2
      );
    }
  }

  @override
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

  @override
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

  @override
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

  @override
  Future<void> deleteAccountRemote() async {
    await client.delete<Map<String, dynamic>>(apiConst.deleteProfile);

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

class AppleSignInExc implements Exception {
  const AppleSignInExc({
    required this.userCredential,
    required this.authorizationCredentialAppleID,
    required this.exc,
  });

  final UserCredential? userCredential;
  final AuthorizationCredentialAppleID? authorizationCredentialAppleID;
  final MqRemoteException? exc;
}

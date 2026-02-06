import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

@immutable
final class AuthRemoteDataSource {
  const AuthRemoteDataSource({
    required this.client,
    required this.googleSocialAuthService,
    required this.appleSocialAuthService,
  });

  final MqRemoteClient client;
  final GoogleSocialAuthService googleSocialAuthService;
  final AppleSocialAuthService appleSocialAuthService;

  Future<void> loginWithEmail(String email) async {
    try {
      await client.postType(
        '/api/v1/accounts/otp/send/',
        fromJson: Map<String, dynamic>.from,
        body: {'email': email},
      );
    } on Object catch (e) {
      log('AuthRemoteDataSource loginWithEmail:', error: e);
      rethrow;
    }
  }

  Future<AuthModel> verifyOtp({
    required String email,
    required String otp,
    required String languageCode,
    required Gender gender,
  }) {
    try {
      return client.postType(
        '/api/v1/accounts/otp/verify/',
        fromJson: AuthModel.fromJson,
        body: {'email': email, 'opt': otp},
      );
    } on Object catch (e) {
      log('AuthRemoteDataSource verifyOtp:', error: e);
      rethrow;
    }
  }

  Future<AuthModel> signInWithGoogle(
    String languageCode,
    Gender gender,
  ) async {
    try {
      final googleAuth = await googleSocialAuthService.signIn();
      return client.postType(
        '/api/v1/accounts/google/',
        fromJson: AuthModel.fromJson,
        body: {
          'access_token': googleAuth?.accessToken ?? '',
          'gender': gender.name,
          'language': languageCode,
        },
      );
    } on Object catch (e) {
      log('AuthRemoteDataSource signInWithGoogle:', error: e);
      rethrow;
    }
  }

  Future<AuthModel> signInWithApple(
    String languageCode,
    Gender gender,
  ) async {
    try {
      final appleAuth = await appleSocialAuthService.signInWithApple();
      return client.postType(
        '/api/v1/accounts/apple/',
        fromJson: AuthModel.fromJson,
        body: {
          'access_token': appleAuth.accessToken,
          'id_token': appleAuth.identityToken,
          'gender': gender.name,
          'language': languageCode,
        },
      );
    } on Object catch (e) {
      log('AuthRemoteDataSource signInWithApple:', error: e);
      rethrow;
    }
  }

  Future<UserModel> getUserData(String userId) {
    try {
      return client.getType(
        '/api/v1/accounts/profile/$userId/',
        fromJson: UserModel.fromJson,
      );
    } on Object catch (e) {
      log('AuthRemoteDataSource getUserData:', error: e);
      rethrow;
    }
  }

  Future<UserModel> saveUser(AuthModel auth) {
    try {
      return client.putType(
        '/api/v1/accounts/profile/${auth.key}/',
        fromJson: UserModel.fromJson,
        body: auth.user.toJson(),
      );
    } on Object catch (e) {
      log('AuthRemoteDataSource saveUserData:', error: e);
      rethrow;
    }
  }

  Future<void> setNotificationToken({
    required String userId,
    required String notificationToken,
    required String deviceType,
    required String deviceId,
    required String deviceTimezone,
  }) {
    try {
      return client.postResponse<void>(
        '/api/v1/accounts/devices/',
        body: {
          'name': userId,
          'registration_id': notificationToken,
          'type': deviceType,
          'device_id': deviceId,
          'timezone': deviceTimezone,
        },
      );
    } on Object catch (e) {
      log('AuthRemoteDataSource patchNotificationToken:', error: e);
      rethrow;
    }
  }

  Future<UserModel> patchUserData(UpdateUserDataParam param) {
    try {
      return client.patchType(
        '/api/v1/accounts/profile/${param.userId}/',
        body: param.toJson(),
        fromJson: UserModel.fromJson,
      );
    } on Object catch (e) {
      log('AuthRemoteDataSource toggleNotification:', error: e);
      rethrow;
    }
  }

  Future<NotificationCount> getNotificationCount(
    String userId,
  ) {
    try {
      return client.getType(
        '/api/v1/notifications/unread_count/',
        fromJson: NotificationCount.fromJson,
      );
    } on Object catch (e) {
      log('AuthRemoteDataSource getNotificationCount:', error: e);
      rethrow;
    }
  }

  Future<List<NotificationModel>> getNotifications(
    String userId,
    String locale,
  ) {
    try {
      return client.getListOfType(
        '/api/v1/notifications/',
        fromJson: NotificationModel.fromJson,
      );
    } on Object catch (e) {
      log('AuthRemoteDataSource getNotifications:', error: e);
      rethrow;
    }
  }

  Future<List<UserActivityModel>> getUserActivity(String userId) {
    try {
      return client.getListOfType(
        'https://eldar2021.github.io/my-quran/activity/mock_activity.json',
        fromJson: UserActivityModel.fromJson,
      );
    } on Object catch (e) {
      log('AuthRemoteDataSource getUserActivity:', error: e);
      rethrow;
    }
  }

  Future<UserRatingMainModel> getUserRatingMain(String userId) {
    try {
      return client.getType(
        '/api/v1/accounts/rating_main/',
        fromJson: UserRatingMainModel.fromJson,
      );
    } on Object catch (e) {
      log('AuthRemoteDataSource getUserRatingMain:', error: e);
      rethrow;
    }
  }

  Future<void> deleteAccount() async {
    try {
      await client.deleteResponse<void>(
        '/api/v1/accounts/profile/delete_my_account/',
      );
      await googleSocialAuthService.deleteAccount();
    } on Object catch (e) {
      log('AuthRemoteDataSource deleteAccount:', error: e);
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await googleSocialAuthService.logOut();
    } on Object catch (e) {
      log('AuthRemoteDataSource logout:', error: e);
      rethrow;
    }
  }
}

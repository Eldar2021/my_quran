import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

@immutable
final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;

  @override
  AuthModel? get initialAuth => localDataSource.initialAuth;

  @override
  Future<void> saveUser(AuthModel user) async {
    await localDataSource.saveUser(user);
  }

  @override
  Future<void> loginWithEmail(String email) async {
    await remoteDataSource.loginWithEmail(email);
  }

  @override
  Future<AuthModel> verifyOtp({
    required String email,
    required String otp,
    required String languageCode,
    required Gender gender,
  }) async {
    final auth = await remoteDataSource.verifyOtp(
      email: email,
      otp: otp,
      languageCode: languageCode,
      gender: gender,
    );
    await localDataSource.saveUser(auth);
    return auth;
  }

  @override
  Future<AuthModel> signWithGoogle(
    String languageCode,
    Gender gender,
  ) async {
    final auth = await remoteDataSource.signInWithGoogle(
      languageCode,
      gender,
    );
    await localDataSource.saveUser(auth);
    return auth;
  }

  @override
  Future<AuthModel> signWithApple(
    String languageCode,
    Gender gender,
  ) async {
    final auth = await remoteDataSource.signInWithApple(
      languageCode,
      gender,
    );
    await localDataSource.saveUser(auth);
    return auth;
  }

  @override
  Future<UserModel> getUserData(String userId) async {
    final res = await remoteDataSource.getUserData(userId);
    await localDataSource.saveUser(AuthModel(key: userId, user: res));
    return res;
  }

  @override
  Future<void> setNotificationToken({
    required String userId,
    required String notificationToken,
    required String deviceType,
    required String deviceId,
    required String deviceTimezone,
  }) async {
    await remoteDataSource.setNotificationToken(
      userId: userId,
      notificationToken: notificationToken,
      deviceType: deviceType,
      deviceId: deviceId,
      deviceTimezone: deviceTimezone,
    );
    await localDataSource.saveNotificationToken(notificationToken);
  }

  @override
  Future<NotificationCount> getNotificationCount(String userId) {
    return remoteDataSource.getNotificationCount(userId);
  }

  @override
  Future<List<NotificationModel>> getNotifications(
    String userId,
    String locale,
  ) {
    return remoteDataSource.getNotifications(userId, locale);
  }

  @override
  Future<UserModel> patchUserData(UpdateUserDataParam param) async {
    final res = await remoteDataSource.patchUserData(param);
    await localDataSource.saveUser(
      AuthModel(key: param.userId, user: res),
    );
    return res;
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await localDataSource.clearUserData();
      await remoteDataSource.deleteAccount();
    } on Object catch (e) {
      log('AuthRepositoryImpl deleteAccount:', error: e);
      return Future.value();
    }
  }

  @override
  Future<void> logout() async {
    try {
      await localDataSource.clearUserData();
      await remoteDataSource.logout();
    } on Object catch (e) {
      log('AuthRepositoryImpl logout:', error: e);
      return Future.value();
    }
  }
}

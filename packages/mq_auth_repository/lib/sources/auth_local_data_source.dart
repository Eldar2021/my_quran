import 'dart:convert';
import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_storage/mq_storage.dart';

@immutable
final class AuthLocalDataSource {
  const AuthLocalDataSource(this.storage);

  final PreferencesStorage storage;

  static const tokenKey = 'token-new';
  static const userKey = 'user';
  static const notificationTokenKey = 'notification-token';

  AuthModel? get initialAuth {
    try {
      final token = storage.readString(key: tokenKey);
      final user = storage.readString(key: userKey);

      if (token != null && user != null) {
        return AuthModel(
          key: token,
          user: UserModel.fromJson(jsonDecode(user) as Map<String, dynamic>),
        );
      }

      return null;
    } on Object catch (e) {
      log('AuthLocalDataSource init:', error: e);
      return null;
    }
  }

  String? getToken() {
    try {
      return storage.readString(key: tokenKey);
    } on Object catch (e) {
      log('AuthLocalDataSource getToken:', error: e);
      return null;
    }
  }

  String? getNotificationToken() {
    try {
      return storage.readString(key: notificationTokenKey);
    } on Object catch (e) {
      log('AuthLocalDataSource getNotificationToken:', error: e);
      return null;
    }
  }

  Future<void> saveUser(AuthModel userModel) async {
    try {
      await Future.wait([
        storage.writeString(
          key: tokenKey,
          value: userModel.key,
        ),
        storage.writeString(
          key: userKey,
          value: jsonEncode(userModel.user.toJson()),
        ),
      ]);
    } on Object catch (e) {
      log('AuthLocalDataSource saveUser:', error: e);
    }
  }

  Future<void> saveNotificationToken(String notificationToken) async {
    try {
      await storage.writeString(
        key: notificationTokenKey,
        value: notificationToken,
      );
    } on Object catch (e) {
      log('AuthLocalDataSource saveNotificationToken:', error: e);
    }
  }

  Future<void> clearUserData() async {
    try {
      await Future.wait([
        storage.delete(key: tokenKey),
        storage.delete(key: userKey),
      ]);
    } on Object catch (e) {
      log('AuthLocalDataSource clearUserData:', error: e);
    }
  }
}

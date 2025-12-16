import 'dart:developer';
import 'dart:io';

import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/core/core.dart';

class NotificationRepository {
  const NotificationRepository({
    required this.client,
    required this.storage,
  });

  static const _notificationEnabledKey = 'notification_enabled';
  static const fcmTokenCacheKey = 'fcm_token_cache';

  final MqRemoteClient client;
  final PreferencesStorage storage;

  Future<void> setNotificationToken({
    required String token,
    required String userToken,
    required String locale,
  }) async {
    try {
      await client.postResponse<void>(
        'api/v1/accounts/devices/',
        body: {
          'name': userToken,
          'registration_id': token,
          'type': Platform.isIOS ? 'ios' : 'android',
        },
      );
      await Future.wait([
        storage.writeString(
          key: _notificationEnabledKey,
          value: token,
        ),
        storage.writeString(
          key: fcmTokenCacheKey,
          value: token,
        ),
      ]);
    } on Object catch (e) {
      log('setNotificationToken', error: e);
    }
  }

  Future<void> toggleNotification({
    required bool value,
    required String userToken,
  }) async {
    try {
      await client.patchResponse<void>(
        'api/v1/accounts/profile/$userToken/',
        body: {
          'allow_notifications': value,
        },
      );
      await storage.writeBool(
        key: _notificationEnabledKey,
        value: value,
      );
    } on Object catch (e) {
      log('toggleNotification', error: e);
    }
  }

  Future<List<NotificationModel>?> getNotifications(String? locale) async {
    if (locale == null) return null;
    try {
      return const [
        NotificationModel(
          id: '1',
          title: 'title',
          body: 'body',
          type: 'type',
        ),
        NotificationModel(
          id: '2',
          title: 'title',
          body: 'body',
          type: 'type',
        ),
        NotificationModel(
          id: '2',
          title: 'title',
          body: 'body',
          type: 'type',
        ),
      ];
    } on Object catch (e) {
      log('getNotificationToken', error: e);
      return null;
    }
  }
}

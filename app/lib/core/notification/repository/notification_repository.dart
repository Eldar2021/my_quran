import 'dart:developer';

import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:mq_storage/mq_storage.dart';

class NotificationRepository {
  const NotificationRepository({
    required this.client,
    required this.storage,
  });

  static const _notificationEnabledKey = 'notification_enabled';

  final MqRemoteClient client;
  final PreferencesStorage storage;

  Future<void> setNotificationToken({
    required String token,
    required String userToken,
    required String locale,
  }) async {
    try {
      await client.post<void>(
        'api/send/notification/token',
        body: {
          'token': token,
          'user_token': userToken,
          'locale': locale,
        },
      );
      await storage.writeString(
        key: _notificationEnabledKey,
        value: token,
      );
    } on Object catch (e) {
      log('setNotificationToken', error: e);
    }
  }

  Future<void> toggleNotification({
    required bool value,
    required String userToken,
  }) async {
    try {
      await client.put<void>(
        'api/send/notification/token',
        body: {
          'value': value,
          'user_token': userToken,
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
}

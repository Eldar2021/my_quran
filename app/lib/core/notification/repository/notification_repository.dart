import 'dart:developer';

import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/core/core.dart';

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
    await Future<void>.delayed(const Duration(seconds: 1));
    try {
      // await client.post<void>(
      //   'api/send/notification/token',
      //   body: {
      //     'token': token,
      //     'user_token': userToken,
      //     'locale': locale,
      //   },
      // );
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
      await Future<void>.delayed(const Duration(seconds: 1));
      // await client.put<void>(
      //   'api/send/notification/token',
      //   body: {
      //     'value': value,
      //     'user_token': userToken,
      //   },
      // );
      await storage.writeBool(
        key: _notificationEnabledKey,
        value: value,
      );
    } on Object catch (e) {
      log('toggleNotification', error: e);
    }
  }

  Future<List<NotificationModel>?> getNotifications(String? locale) async {
    await Future<void>.delayed(const Duration(seconds: 1));
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

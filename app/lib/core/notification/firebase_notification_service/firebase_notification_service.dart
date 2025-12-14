import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:my_quran/core/notification/notification.dart';

typedef OnSendTokenToServer = FutureOr<void> Function(String fcmToken);
typedef FirebaseNotificationClickHandler = void Function(Map<String, dynamic> data);

class FirebaseNotificationService {
  const FirebaseNotificationService({
    required this.firebaseMessaging,
    required this.onShowNotification,
  });

  final FirebaseMessaging firebaseMessaging;
  final FutureOr<void> Function(RemoteMessage message) onShowNotification;

  Future<void> initialize({
    required OnSendTokenToServer onSendTokenToServer,
    required FirebaseNotificationClickHandler onNotificationClick,
    required FutureOr<void> Function() onPermissionEnabled,
    required FutureOr<void> Function() onPermissionDisabled,
  }) async {
    final settings = await firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('🔔 User granted permission for notifications');
      await onPermissionEnabled();

      if (Platform.isIOS) {
        await firebaseMessaging.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
      }

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log('🔔 Ön Planda Bildirim Geldi: ${message.notification?.title}');
        onShowNotification(message);
      });

      await _setupInteractedMessage(onNotificationClick);

      final fcmToken = await firebaseMessaging.getToken();
      log('========================================');
      log('TOKEN: $fcmToken');
      log('========================================');

      if (fcmToken != null) {
        await onSendTokenToServer(fcmToken);
      }

      firebaseMessaging.onTokenRefresh.listen((newToken) async {
        await onSendTokenToServer(newToken);
      });
    } else {
      log('🔕 User denied permission for notifications');
      await onPermissionDisabled();
    }
  }

  Future<void> _setupInteractedMessage(
    FirebaseNotificationClickHandler onNotificationClick,
  ) async {
    final initialMessage = await firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage, onNotificationClick);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) => _handleMessage(message, onNotificationClick),
    );
  }

  void _handleMessage(
    RemoteMessage message,
    FirebaseNotificationClickHandler onNotificationClick,
  ) {
    log('Tapped on notification (Background/Terminated): ${message.data}');
    onNotificationClick(message.data);
  }
}

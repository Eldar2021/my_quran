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
    required FutureOr<void> Function() onReceiveNotification,
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
        onReceiveNotification();
        onShowNotification(message);
      });

      await _setupInteractedMessage(onNotificationClick);

      final fcmToken = await firebaseMessaging.getToken();
      log('========================================');
      log('✅ FCM TOKEN: $fcmToken');
      log('========================================');

      if (fcmToken != null) {
        await onSendTokenToServer(fcmToken);
      }

      firebaseMessaging.onTokenRefresh.listen((newToken) async {
        log('========================================');
        log('✅ FCM TOKEN REFRESH: $newToken');
        log('========================================');
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
    // onNotificationClick(message.data);
    final payload = {
      'id': '100',
      'is_read': false,
      'type': 'STANDARD',
      'avatar':
          'https://img.freepik.com/free-photo/animal-eye-staring-close-up-watch-nature-generative-ai_188544-15471.jpg?semt=ais_hybrid&w=740&q=80',
      'title': 'Hi Eldiiar! Firebase Msj',
      'description':
          "May this Friday bring peace and happiness to your heart. Don't forget to read Surah Al-Kahf today.",
      'date': '2025-12-22T14:30:00.000Z',
      'image': 'https://images.unsplash.com/photo-1564121211835-e88c852648ab?w=600&q=80',
      'action': {
        'button_text': 'Read Al-Kahf',
        'is_active': true,
        'action_type': 'JOIN_TO_HATIM',
        'payload': {'surah_id': 18},
      },
    };

    onNotificationClick(payload);
  }
}

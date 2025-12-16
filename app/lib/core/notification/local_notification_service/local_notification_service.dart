import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

typedef LocalNotificationClickHandler = void Function(String payload);

const _channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.max,
);

const initializationSettingsAndroid = AndroidInitializationSettings(
  '@drawable/ic_notification',
);

const initializationSettingsDarwin = DarwinInitializationSettings(
  requestAlertPermission: false,
  requestBadgePermission: false,
  requestSoundPermission: false,
);

const initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
  iOS: initializationSettingsDarwin,
);

class LocalNotificationService {
  const LocalNotificationService(this.localNotification);

  final FlutterLocalNotificationsPlugin localNotification;

  Future<void> initialize({
    required LocalNotificationClickHandler onNotificationClick,
  }) async {
    log('🔧 LocalNotificationService initializing...');

    await localNotification
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    await localNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        log('🔔 Tapped on Notification: ${response.payload}');
        final payload = response.payload;
        if (payload != null) onNotificationClick(payload);
      },
    );

    log('✅ LocalNotificationService initialized.');
  }

  Future<void> showNotification(RemoteMessage message) async {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null && Platform.isAndroid) {
      await localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        payload: jsonEncode(message.data),
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            icon: '@drawable/ic_notification',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      );
    }
  }
}

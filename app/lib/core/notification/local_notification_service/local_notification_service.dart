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
        // final payload = response.payload;
        // if (payload != null) onNotificationClick(payload);
        final payload = jsonEncode({
          'id': '100',
          'is_read': false,
          'type': 'STANDARD',
          'avatar':
              'https://img.freepik.com/free-photo/animal-eye-staring-close-up-watch-nature-generative-ai_188544-15471.jpg?semt=ais_hybrid&w=740&q=80',
          'title': 'Hi Eldiiar! Local Msj',
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
        });

        onNotificationClick(payload);
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

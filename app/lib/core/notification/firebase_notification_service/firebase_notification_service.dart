import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:my_quran/core/notification/notification.dart';

class FirebaseNotificationService {
  factory FirebaseNotificationService() => _instance;

  FirebaseNotificationService._internal();

  static final FirebaseNotificationService _instance = FirebaseNotificationService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    final settings = await _messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('🔔 User granted permission for notifications');
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log('🔔 Ön Planda Bildirim Geldi: ${message.notification?.title}');
        log('📦 Payload: ${message.data}');

        // NOT: Firebase, uygulama ön plandayken bildirimi yukarıdan "Düşürmez".
        // Bunu 2. adımda "Local Notifications" paketiyle biz manuel göstereceğiz.
      });

      final fcmToken = await _messaging.getToken();
      log('========================================');
      log('TOKEN: $fcmToken');
      log('========================================');

      // Token'ı backend'e gönder
      // await _sendTokenToServer(fcmToken);

      // Token yenilenirse (Uygulama silinip yüklenirse vs.) yakala
      _messaging.onTokenRefresh.listen((newToken) {
        log('♻️ Token updated: $newToken');
        // Burada yeni token'ı backend'e gönderen fonksiyon çağrılacak
      });
    } else {
      log('🔕 User denied permission for notifications');
    }
  }

  // Arka planda gelen bildirime tıklanınca çalışacak logic (Sonra ekleyeceğiz)
  Future<void> setupInteractedMessage() async {
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    // Deep Link yönlendirmesi buraya gelecek
    log('Tapped on notification: ${message.data}');
  }
}

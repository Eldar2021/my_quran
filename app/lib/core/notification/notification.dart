import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

export 'firebase_notification_service/firebase_notification_service.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Burada Firebase.initializeApp() çağırmaya gerek yok, yeni sürümler otomatik hallediyor.
  // Ancak local storage veya hive kullanacaksanız burada init etmeniz gerekir.

  log('Background notification: ${message.messageId}');
}

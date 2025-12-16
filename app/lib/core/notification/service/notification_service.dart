import 'dart:async';

import 'package:my_quran/core/core.dart';

class NotificationService {
  NotificationService({
    required this.firebase,
    required this.local,
    required this.repository,
    required this.isIntegrationTesting,
  });

  final FirebaseNotificationService firebase;
  final LocalNotificationService local;
  final NotificationRepository repository;
  final bool isIntegrationTesting;

  bool isInitialized = false;

  Future<void> initialize({
    required String userToken,
    required String locale,
    required LocalNotificationClickHandler onNotificationClick,
    required FirebaseNotificationClickHandler onFirebaseNotificationClick,
    required FutureOr<void> Function() onPermissionEnabled,
    required FutureOr<void> Function() onPermissionDisabled,
  }) async {
    if (isIntegrationTesting) return;
    if (isInitialized) return;
    isInitialized = true;

    await local.initialize(onNotificationClick: onNotificationClick);

    await firebase.initialize(
      onNotificationClick: onFirebaseNotificationClick,
      onPermissionEnabled: onPermissionEnabled,
      onPermissionDisabled: onPermissionDisabled,
      onSendTokenToServer: (fcmToken) {
        return repository.setNotificationToken(
          token: fcmToken,
          userToken: userToken,
          locale: locale,
        );
      },
    );
  }
}

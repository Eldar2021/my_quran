import 'package:my_quran/core/core.dart';

class NotificationService {
  const NotificationService({
    required this.firebase,
    required this.local,
    required this.repository,
  });

  final FirebaseNotificationService firebase;
  final LocalNotificationService local;
  final NotificationRepository repository;

  Future<void> initialize({
    required String userToken,
    required String locale,
  }) async {
    await local.initialize();
    await firebase.initialize(
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

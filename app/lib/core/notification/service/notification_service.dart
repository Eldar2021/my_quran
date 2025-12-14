import 'package:my_quran/core/core.dart';

class NotificationService {
  const NotificationService({
    required this.firebase,
    required this.local,
  });

  final FirebaseNotificationService firebase;
  final LocalNotificationService local;

  Future<void> initialize() async {
    await local.initialize();
    await firebase.initialize();
  }
}

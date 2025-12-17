import 'package:mq_auth_repository/mq_auth_repository.dart';

abstract class AuthRepository {
  AuthModel? get initialAuth;

  Future<void> loginWithEmail(String email);

  String? getNotificationToken();

  Future<AuthModel> verifyOtp({
    required String email,
    required String otp,
    required String languageCode,
    required Gender gender,
  });

  Future<AuthModel> signWithGoogle(
    String languageCode,
    Gender gender,
  );

  Future<AuthModel> signWithApple(
    String languageCode,
    Gender gender,
  );

  Future<void> saveUser(AuthModel user);

  Future<UserModel> patchGender({
    required String userId,
    required Gender gender,
  });

  Future<UserModel> patchLocale({
    required String userId,
    required String localeCode,
  });

  Future<void> patchNotificationToken({
    required String userId,
    required String notificationToken,
    required String deviceType,
  });

  Future<UserModel> toggleNotification({
    required String userId,
    required bool value,
  });

  Future<List<NotificationModel>> getNotifications(
    String userId,
    String locale,
  );

  Future<void> deleteAccount();

  Future<void> logout();
}

import 'package:mq_auth_repository/mq_auth_repository.dart';

abstract class AuthRepository {
  AuthModel? get initialAuth;

  Future<void> loginWithEmail(String email);

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

  Future<UserModel> getUserData(String userId);

  Future<void> saveUser(AuthModel user);

  Future<NotificationCount> getNotificationCount(
    String userId,
  );

  Future<void> setNotificationToken({
    required String userId,
    required String notificationToken,
    required String deviceType,
    required String deviceId,
    required String deviceTimezone,
  });

  Future<List<NotificationModel>> getNotifications(
    String userId,
    String locale,
  );

  Future<UserModel> patchUserData(
    UpdateUserDataParam param,
  );

  Future<void> deleteAccount();

  Future<void> logout();
}

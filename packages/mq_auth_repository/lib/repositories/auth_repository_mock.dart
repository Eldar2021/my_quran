import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

@immutable
final class AuthRepositoryMock implements AuthRepository {
  const AuthRepositoryMock();

  @override
  AuthModel? get initialAuth => null;

  @override
  Future<void> saveUser(AuthModel user) {
    return Future.value();
  }

  @override
  Future<void> loginWithEmail(String email) {
    return Future.value();
  }

  @override
  Future<AuthModel> verifyOtp({
    required String email,
    required String otp,
    required String languageCode,
    required Gender gender,
  }) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => AuthModel.fromJson(_authJsonData),
    );
  }

  @override
  Future<AuthModel> signWithGoogle(
    String languageCode,
    Gender gender,
  ) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => AuthModel.fromJson(_authJsonData),
    );
  }

  @override
  Future<AuthModel> signWithApple(
    String languageCode,
    Gender gender,
  ) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => AuthModel.fromJson(_authJsonData),
    );
  }

  @override
  Future<UserModel> getUserData(String userId) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => UserModel.fromJson(_userJsonData),
    );
  }

  @override
  Future<void> deleteAccount() {
    return Future.value();
  }

  @override
  Future<void> logout() {
    return Future.value();
  }

  @override
  Future<void> setNotificationToken({
    required String userId,
    required String notificationToken,
    required String deviceType,
    required String deviceId,
    required String deviceTimezone,
  }) {
    return Future.value();
  }

  @override
  Future<List<NotificationModel>> getNotifications(
    String userId,
    String locale,
  ) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => notificationJsonData.map(NotificationModel.fromJson).toList(),
    );
  }

  @override
  Future<UserModel> patchUserData(UpdateUserDataParam param) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => UserModel.fromJson(_userJsonData),
    );
  }
}

const _authJsonData = <String, dynamic>{
  'key': 'user_key',
  'user': {
    'first_name': 'Test',
    'last_name': 'User',
    'username': 'test_user',
    'avatar': 'https://lh3.googleusercontent.com/a/ACg8ocLxYr0F89L5FzZv9o_VyCYm3rkX4gtZAxBzyJkpC6yQE7uKuTY2=s96-c',
    'email': 'test_user@gmail.com',
    'country': null,
    'phone_number': null,
    'gender': 'male',
    'language': 'en',
    'can_create_hatim': false,
  },
};

const _userJsonData = <String, dynamic>{
  'first_name': 'Test',
  'last_name': 'User',
  'username': 'test_user',
  'avatar': 'https://lh3.googleusercontent.com/a/ACg8ocLxYr0F89L5FzZv9o_VyCYm3rkX4gtZAxBzyJkpC6yQE7uKuTY2=s96-c',
  'email': 'test_user@gmail.com',
  'country': null,
  'phone_number': null,
  'gender': 'male',
  'language': 'en',
  'can_create_hatim': false,
};

const notificationJsonData = <Map<String, dynamic>>[
  {
    'id': 'ntf_001',
    'title': 'Order Shipped',
    'body': 'Your order #1293 has been shipped. Tap to track your package.',
    'type': 'order_update',
  },
  {
    'id': 'ntf_002',
    'title': '50% Off Everything!',
    'body': "Don't miss out on our biggest sale of the season. Shop now while supplies last.",
    'type': 'promotion',
  },
  {
    'id': 'ntf_003',
    'title': 'Scheduled Maintenance',
    'body': 'We will be performing system maintenance tonight between 02:00 AM and 04:00 AM UTC.',
    'type': 'system_alert',
  },
  {
    'id': 'ntf_004',
    'title': 'New Message',
    'body': 'Sarah Jenkins sent you a photo.',
    'type': 'message',
  },
  {
    'id': 'ntf_005',
    'title': 'Security Alert',
    'body': 'New login detected on your account from a generic device. Was this you?',
    'type': 'security',
  },
  {
    'id': 'ntf_006',
    'title': 'Subscription Renewal',
    'body': 'Your Premium subscription is set to renew in 3 days.',
    'type': 'subscription',
  },
];

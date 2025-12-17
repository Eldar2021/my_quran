import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

@immutable
final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;

  @override
  AuthModel? get initialAuth => localDataSource.initialAuth;

  @override
  Future<void> saveUser(AuthModel user) async {
    await localDataSource.saveUser(user);
  }

  @override
  Future<void> loginWithEmail(String email) async {
    await remoteDataSource.loginWithEmail(email);
  }

  @override
  Future<AuthModel> verifyOtp({
    required String email,
    required String otp,
    required String languageCode,
    required Gender gender,
  }) {
    return remoteDataSource.verifyOtp(
      email: email,
      otp: otp,
      languageCode: languageCode,
      gender: gender,
    );
  }

  @override
  Future<AuthModel> signWithGoogle(
    String languageCode,
    Gender gender,
  ) {
    return remoteDataSource.signInWithGoogle(languageCode, gender);
  }

  @override
  Future<AuthModel> signWithApple(
    String languageCode,
    Gender gender,
  ) {
    return remoteDataSource.signInWithApple(languageCode, gender);
  }

  @override
  Future<UserModel> patchGender({
    required String userId,
    required Gender gender,
  }) async {
    final res = await remoteDataSource.pathGender(
      userId: userId,
      gender: gender,
    );

    await localDataSource.saveUser(
      AuthModel(key: userId, user: res),
    );

    return res;
  }

  @override
  Future<UserModel> patchLocale({
    required String userId,
    required String localeCode,
  }) async {
    final res = await remoteDataSource.pathLocale(
      userId: userId,
      localeCode: localeCode,
    );

    await localDataSource.saveUser(
      AuthModel(key: userId, user: res),
    );

    return res;
  }

  @override
  String? getNotificationToken() {
    return localDataSource.getNotificationToken();
  }

  @override
  Future<void> setNotificationToken({
    required String userId,
    required String notificationToken,
    required String deviceType,
  }) async {
    await remoteDataSource.patchNotificationToken(
      userId: userId,
      notificationToken: notificationToken,
      deviceType: deviceType,
    );
    await localDataSource.saveNotificationToken(notificationToken);
  }

  @override
  Future<List<NotificationModel>> getNotifications(
    String userId,
    String locale,
  ) {
    return remoteDataSource.getNotifications(userId, locale);
  }

  @override
  Future<UserModel> toggleNotification({
    required String userId,
    required bool value,
  }) async {
    final res = await remoteDataSource.toggleNotification(
      userId: userId,
      value: value,
    );

    await localDataSource.saveUser(
      AuthModel(key: userId, user: res),
    );

    return res;
  }

  @override
  Future<void> deleteAccount() async {
    await remoteDataSource.deleteAccount();
    await localDataSource.clearUserData();
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
    await localDataSource.clearUserData();
  }
}

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
  UserModel? get init => localDataSource.init;

  @override
  Future<void> setUserData(UserModel userEntity) async {
    await remoteDataSource.saveUserData(userEntity);
    await localDataSource.saveUserData(userEntity);
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
  }) async {
    final res = await remoteDataSource.verifyOtp(
      email: email,
      otp: otp,
      languageCode: languageCode,
      gender: gender,
    );

    return res;
  }

  @override
  Future<AuthModel> signWithGoogle(
    String languageCode,
    Gender gender,
  ) async {
    final res = await remoteDataSource.signInWithGoogle(
      languageCode,
      gender,
    );

    return res;
  }

  @override
  Future<AuthModel> signWithApple(
    String languageCode,
    Gender gender,
  ) async {
    final res = await remoteDataSource.signInWithApple(
      languageCode,
      gender,
    );

    return res;
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

    await localDataSource.saveGender(gender);

    return res;
  }

  @override
  Future<UserModel> patchLocaleCode({
    required String userId,
    required String localeCode,
  }) async {
    final res = await remoteDataSource.pathLocaleCode(
      userId: userId,
      localeCode: localeCode,
    );

    await localDataSource.saveLocaleCode(localeCode);

    return res;
  }

  @override
  Future<void> deleteAccount() async {
    await remoteDataSource.deleteAccountRemote();
    await localDataSource.deleteAccountLocal();
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logoutRemote();
    await localDataSource.logoutLocal();
  }
}

import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:mq_either/mq_either.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';

@immutable
final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;

  @override
  UserEntity? get init => localDataSource.init;

  @override
  Future<void> setUserData(UserEntity userEntity) async {
    try {
      await remoteDataSource.saveUserData(userEntity);
      await localDataSource.saveUserData(userEntity);
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      log('setUserData error $e,\n$s');
    }
  }

  @override
  Future<void> loginWithEmail(String email) async {
    try {
      await remoteDataSource.loginWithEmail(email);
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      log('signWithEmail: error: $e\n$s');
    }
  }

  @override
  Future<Either<UserEntity, Exception>> verifyOtp({
    required String email,
    required String otp,
    required String languageCode,
    required Gender gender,
  }) async {
    try {
      final res = await remoteDataSource.verifyOtp(
        email: email,
        otp: otp,
        languageCode: languageCode,
        gender: gender,
      );

      return res.fold(
        Left.new,
        (r) {
          final userEntity = UserEntity(
            accessToken: r.accessToken,
            username: r.username,
            gender: r.gender,
            localeCode: r.localeCode,
          );
          return Right(userEntity);
        },
      );
    } catch (e, s) {
      log('signWithemail: error: $e\n$s');
      MqCrashlytics.report(e, s);
      return Left(AuthenticationExc(message: e.toString()));
    }
  }

  @override
  Future<Either<UserEntity, Exception>> signWithGoogle(
    String languageCode,
    Gender gender,
  ) async {
    final res = await remoteDataSource.signInWithGoogle(languageCode, gender);
    return res.fold(
      Left.new,
      (r) => Right(
        UserEntity(
          accessToken: r.accessToken,
          username: r.username,
          gender: r.gender,
          localeCode: r.localeCode,
        ),
      ),
    );
  }

  @override
  Future<Either<UserEntity, Exception>> signWithApple(
    String languageCode,
    Gender gender,
  ) async {
    final res = await remoteDataSource.signInWithApple(languageCode, gender);
    return res.fold(
      Left.new,
      (r) => Right(
        UserEntity(
          accessToken: r.accessToken,
          username: r.username,
          gender: r.gender,
          localeCode: r.localeCode,
        ),
      ),
    );
  }

  @override
  Future<Either<UserDataEntity, Exception>> patchGender({
    required String userId,
    required Gender gender,
  }) async {
    final res = await remoteDataSource.pathGender(userId: userId, gender: gender);
    return res.fold(Left.new, (r) async {
      final entity = UserDataEntity(gender: r.gender, language: r.language);
      await localDataSource.saveGender(gender);
      return Right(entity);
    });
  }

  @override
  Future<Either<UserDataEntity, Exception>> patchLocaleCode({
    required String userId,
    required String localeCode,
  }) async {
    final res = await remoteDataSource.pathLocaleCode(userId: userId, localeCode: localeCode);
    return res.fold(Left.new, (r) async {
      final entity = UserDataEntity(gender: r.gender, language: r.language);
      await localDataSource.saveLocaleCode(localeCode);
      return Right(entity);
    });
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await remoteDataSource.deleteAccountRemote();
      await localDataSource.deleteAccountLocal();
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      log('Delete Account error: $e\n$s');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logoutRemote();
      await localDataSource.logoutLocal();
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      log('logout error: $e\n$s');
    }
  }
}

import 'dart:developer';

import 'package:meta/meta.dart';
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
  UserEntity? get init {
    return localDataSource.init;
  }

  @override
  Future<void> saveGender(Gender gender) async {
    await localDataSource.saveGender(gender);
  }

  @override
  Future<Either<UserEntity, Exception>> signWithGoogle(
    String languageCode,
    Gender gender,
  ) async {
    try {
      final res = await remoteDataSource.signInWithGoogle(languageCode, gender);
      return res.fold(
        Left.new,
        (r) => Right(
          UserEntity(
            accessToken: r.accessToken,
            username: r.username,
            gender: r.gender,
          ),
        ),
      );
    } catch (e, s) {
      log('signWithGoogle: error: $e\n$s');
      return Left(AuthenticationExc(message: e.toString()));
    }
  }

  @override
  Future<Either<UserEntity, Exception>> signWithApple(
    String languageCode,
    Gender gender,
  ) async {
    try {
      return const Right(
        UserEntity(
          accessToken: '',
          username: '',
        ),
      );
    } catch (e, s) {
      log('signWithGoogle: error: $e\n$s');
      return Left(AuthenticationExc(message: e.toString()));
    }
  }
}

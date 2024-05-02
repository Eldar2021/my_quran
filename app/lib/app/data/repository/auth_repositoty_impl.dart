import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';

@immutable
final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.soccialAuth,
  });

  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;
  final SoccialAuth soccialAuth;

  @override
  UserEntity? get init {
    return localDataSource.init;
  }

  @override
  Future<void> saveGender(Gender gender) async {
    await localDataSource.saveGender(gender);
  }

  // UserEntity _convertData(UserModelResponse response) {
  //   return UserEntity(
  //     accessToken: response.accessToken,
  //     username: response.username,
  //     gender: response.gender,
  //   );
  // }

  @override
  Future<Either<UserEntity, Exception>> signWithGoogle() async {
    try {
      final googleAuth = await soccialAuth.signInWithGoogle();
      log('${googleAuth.credential}');
      // sent to backend
      return const Right(UserEntity(accessToken: ' ', username: ''));
    } catch (e, s) {
      log('signWithGoogle: error: $e\n$s');
      return Left(AuthenticationExc(message: e.toString()));
    }
  }
}

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
  Future<Either<UserEntity, Exception>> login(String languageCode, Gender gender) async {
    try {
      final result = await remoteDataSource.login(languageCode, gender);
      return result.fold(
        Left.new,
        (r) async {
          return Right(_convertData(r));
        },
      );
    } catch (e) {
      return Left(e as Exception);
    }
  }

  @override
  Future<void> saveGender(Gender gender) async {
    await localDataSource.saveGender(gender);
  }

  UserEntity _convertData(UserModelResponse response) {
    return UserEntity(
      accessToken: response.accessToken,
      username: response.username,
      gender: response.gender,
    );
  }
}

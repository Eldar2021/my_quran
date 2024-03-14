import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/models/models.dart';

@immutable
final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;

  @override
  User? get init {
    return localDataSource.init;
  }

  @override
  Future<Either<User, Exception>> login(String languageCode, Gender gender) async {
    final user = await remoteDataSource.login(languageCode, gender);
    return user;
  }

  @override
  Future<void> saveGender(Gender gender) async {
    await localDataSource.saveGender(gender);
  }
}

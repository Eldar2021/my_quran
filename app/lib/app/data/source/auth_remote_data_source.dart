import 'package:meta/meta.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';

@immutable
final class AuthRemoteDataSource {
  const AuthRemoteDataSource({
    required this.client,
    required this.storage,
    required this.soccialAuth,
  });

  final RemoteClient client;
  final PreferencesStorage storage;
  final SoccialAuth soccialAuth;

  Future<Either<UserModelResponse, Exception>> signInWithGoogle(
    String languageCode,
    Gender gender,
  ) async {
    final googleAuth = await soccialAuth.signInWithGoogle();

    final token = await client.post(
      apiConst.loginWithGoogle,
      fromJson: TokenResponse.fromJson,
      body: {'access_token': googleAuth.credential?.accessToken},
    );

    return token.fold(Left.new, (r) async {
      final user = UserModelResponse(
        accessToken: r.key,
        username: googleAuth.user?.displayName ?? '',
        gender: gender,
      );

      await Future.wait([
        storage.writeString(key: StorageKeys.tokenKey, value: user.accessToken),
        storage.writeString(key: StorageKeys.genderKey, value: user.gender!.name),
        storage.writeString(key: StorageKeys.usernameKey, value: user.username),
      ]);

      return Right(user);
    });
  }
}

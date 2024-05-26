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
        localeCode: languageCode,
      );

      await storage.writeString(key: StorageKeys.tokenKey, value: user.accessToken);

      return Right(user);
    });
  }

  Future<Either<UserDataResponse, Exception>> saveUserData(UserEntity userEntity) {
    return client.put(
      apiConst.putProfile(userEntity.accessToken),
      fromJson: UserDataResponse.fromJson,
      body: {
        'gender': userEntity.gender.name.toUpperCase(),
        'language': userEntity.localeCode.toUpperCase(),
      },
      token: userEntity.accessToken,
    );
  }

  Future<Either<UserDataResponse, Exception>> pathGender({
    required String userId,
    required Gender gender,
  }) {
    return client.patch(
      apiConst.putProfile(userId),
      fromJson: UserDataResponse.fromJson,
      body: {'gender': gender.name.toUpperCase()},
      token: userId,
    );
  }

  Future<Either<UserDataResponse, Exception>> pathLocaleCode({
    required String userId,
    required String localeCode,
  }) {
    return client.patch(
      apiConst.putProfile(userId),
      fromJson: UserDataResponse.fromJson,
      body: {'language': localeCode.toUpperCase()},
      token: userId,
    );
  }
}

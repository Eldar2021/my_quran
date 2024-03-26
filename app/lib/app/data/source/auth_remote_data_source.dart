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
  });

  final RemoteClient client;
  final PreferencesStorage storage;

  Future<Either<UserModelResponse, Exception>> login(String languageCode, Gender gender) async {
    final user = await client.post<UserModelResponse>(
      apiConst.signUp,
      fromJson: UserModelResponse.fromJson,
      body: <String, dynamic>{
        'gender': gender.name.toUpperCase(),
        'languageCode': languageCode,
      },
    );

    return user.fold(
      Left.new,
      (r) async {
        final user = r.copyWith(gender: gender);
        await Future.wait([
          storage.writeString(key: StorageKeys.tokenKey, value: user.accessToken),
          storage.writeString(key: StorageKeys.genderKey, value: user.gender!.name),
          storage.writeString(key: StorageKeys.usernameKey, value: user.username),
        ]);

        return Right(user);
      },
    );
  }
}

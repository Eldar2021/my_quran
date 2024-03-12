import 'package:flutter/cupertino.dart';

import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/models/models.dart';

@immutable
final class AuthService {
  const AuthService(this.storage, this.client);

  final PreferencesStorage storage;
  final RemoteClient client;

  User? get init {
    final userToken = storage.readString(key: StorageKeys.tokenKey);
    final userGender = storage.readString(key: StorageKeys.genderKey);
    final username = storage.readString(key: StorageKeys.usernameKey);
    if (userToken == null && userGender == null && username == null) return null;
    return User(
      accessToken: userToken!,
      username: username!,
      gender: userGender == Gender.male.name ? Gender.male : Gender.female,
    );
  }

  String? getToken() => storage.readString(key: StorageKeys.tokenKey);

  Future<Either<User, Exception>> login(String languageCode, Gender gender) async {
    final user = await client.post<User>(
      apiConst.signUp,
      fromJson: User.fromJson,
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

  Future<void> changeGender(Gender gender) async {
    await storage.writeString(key: StorageKeys.genderKey, value: gender.name);
  }
}

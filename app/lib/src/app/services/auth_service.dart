import 'package:flutter/cupertino.dart';

import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/src/src.dart';

@immutable
final class AuthService {
  const AuthService(this.storage, this.client);

  final PreferencesStorage storage;
  final RemoteClient client;

  User? get init {
    final userToken = storage.readString(key: AppConst.tokenKey);
    final userGender = storage.readString(key: AppConst.genderKey);
    final username = storage.readString(key: AppConst.usernameKey);
    if (userToken == null && userGender == null && username == null) return null;
    return User(
      accessToken: userToken!,
      username: username!,
      gender: userGender == Gender.male.name ? Gender.male : Gender.female,
    );
  }

  String? getToken() => storage.readString(key: AppConst.tokenKey);

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
        await storage.writeString(key: AppConst.tokenKey, value: user.accessToken);
        await storage.writeString(key: AppConst.genderKey, value: user.gender!.name);
        await storage.writeString(key: AppConst.usernameKey, value: user.username);
        return Right(user);
      },
    );
  }

  Future<void> changeGender(Gender gender) async {
    await storage.writeString(key: AppConst.genderKey, value: gender.name);
  }
}

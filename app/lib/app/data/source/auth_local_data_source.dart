import 'package:meta/meta.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/constants/contants.dart';

@immutable
final class AuthLocalDataSource {
  const AuthLocalDataSource(this.storage);

  final PreferencesStorage storage;

  UserEntity? get init {
    final userToken = storage.readString(key: StorageKeys.tokenKey);
    final userGender = storage.readString(key: StorageKeys.genderKey);
    final username = storage.readString(key: StorageKeys.usernameKey);
    final localeCode = storage.readString(key: StorageKeys.localeKey);
    if (userToken == null && userGender == null && username == null) return null;
    return UserEntity(
      accessToken: userToken!,
      username: username!,
      gender: userGender == Gender.male.name ? Gender.male : Gender.female,
      localeCode: localeCode ?? 'en',
    );
  }

  String? getToken() => storage.readString(key: StorageKeys.tokenKey);

  Future<void> saveUserData(UserEntity userEntity) async {
    await Future.wait([
      storage.writeString(key: StorageKeys.localeKey, value: userEntity.localeCode),
      storage.writeString(key: StorageKeys.genderKey, value: userEntity.gender.name),
      storage.writeString(key: StorageKeys.usernameKey, value: userEntity.username),
    ]);
  }
}

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
    if (userToken == null && userGender == null && username == null) return null;
    return UserEntity(
      accessToken: userToken!,
      username: username!,
      gender: userGender == Gender.male.name ? Gender.male : Gender.female,
    );
  }

  String? getToken() => storage.readString(key: StorageKeys.tokenKey);

  Future<void> saveGender(Gender gender) async {
    await storage.writeString(key: StorageKeys.genderKey, value: gender.name);
  }
}

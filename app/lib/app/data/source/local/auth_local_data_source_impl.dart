import 'package:meta/meta.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/constants/contants.dart';

@immutable
final class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl(this.storage);

  final PreferencesStorage storage;

  @override
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

  @override
  String? getToken() => storage.readString(key: StorageKeys.tokenKey);

  @override
  Future<void> saveUserData(UserEntity userEntity) async {
    await Future.wait([
      storage.writeString(key: StorageKeys.localeKey, value: userEntity.localeCode),
      storage.writeString(key: StorageKeys.genderKey, value: userEntity.gender.name),
      storage.writeString(key: StorageKeys.usernameKey, value: userEntity.username),
    ]);
  }

  @override
  Future<void> saveGender(Gender gender) {
    return storage.writeString(
      key: StorageKeys.genderKey,
      value: gender.name,
    );
  }

  @override
  Future<void> saveLocaleCode(String localeCode) {
    return storage.writeString(
      key: StorageKeys.localeKey,
      value: localeCode,
    );
  }

  @override
  Future<void> deleteAccountLocal() async {
    await storage.clear();
    await storage.delete(key: StorageKeys.tokenKey);
  }

  @override
  Future<void> logoutLocal() async {
    await storage.clear();
  }
}

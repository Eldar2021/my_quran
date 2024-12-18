import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_storage/mq_storage.dart';

@immutable
final class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl(this.storage);

  final PreferencesStorage storage;

  @override
  UserEntity? get init {
    final userToken = storage.readString(key: AuthLocalDataSourceKeys.tokenKey);
    final userGender = storage.readString(key: AuthLocalDataSourceKeys.genderKey);
    final username = storage.readString(key: AuthLocalDataSourceKeys.usernameKey);
    final localeCode = storage.readString(key: AuthLocalDataSourceKeys.localeKey);
    if (userToken == null && userGender == null && username == null) return null;
    return UserEntity(
      accessToken: userToken!,
      username: username!,
      gender: userGender == Gender.male.name ? Gender.male : Gender.female,
      localeCode: localeCode ?? 'en',
    );
  }

  @override
  String? getToken() => storage.readString(key: AuthLocalDataSourceKeys.tokenKey);

  @override
  Future<void> saveUserData(UserEntity userEntity) async {
    await Future.wait([
      storage.writeString(
        key: AuthLocalDataSourceKeys.localeKey,
        value: userEntity.localeCode,
      ),
      storage.writeString(
        key: AuthLocalDataSourceKeys.genderKey,
        value: userEntity.gender.name,
      ),
      storage.writeString(
        key: AuthLocalDataSourceKeys.usernameKey,
        value: userEntity.username,
      ),
    ]);
  }

  @override
  Future<void> saveGender(Gender gender) {
    return storage.writeString(
      key: AuthLocalDataSourceKeys.genderKey,
      value: gender.name,
    );
  }

  @override
  Future<void> saveLocaleCode(String localeCode) {
    return storage.writeString(
      key: AuthLocalDataSourceKeys.localeKey,
      value: localeCode,
    );
  }

  @override
  Future<void> deleteAccountLocal() async {
    await storage.clear();
    await storage.delete(key: AuthLocalDataSourceKeys.tokenKey);
  }

  @override
  Future<void> logoutLocal() async {
    await storage.clear();
  }
}

@immutable
abstract interface class AuthLocalDataSourceKeys {
  static const localeKey = 'locale';
  static const tokenKey = 'token-new';
  static const genderKey = 'gender';
  static const usernameKey = 'username';
}

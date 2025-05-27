import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_storage/mq_storage.dart';

@immutable
final class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl(this.storage);

  final PreferencesStorage storage;

  @override
  UserModelResponse? get init {
    final userToken = storage.readString(key: MqAuthStatics.tokenKey);
    final userGender = storage.readString(key: MqAuthStatics.genderKey);
    final username = storage.readString(key: MqAuthStatics.usernameKey);
    final localeCode = storage.readString(key: MqAuthStatics.localeKey);
    if (userToken == null && userGender == null && username == null) return null;
    return UserModelResponse(
      accessToken: userToken!,
      username: username!,
      gender: userGender == Gender.male.name ? Gender.male : Gender.female,
      localeCode: localeCode ?? 'en',
    );
  }

  @override
  String? getToken() => storage.readString(key: MqAuthStatics.tokenKey);

  @override
  Future<void> saveUserData(UserModelResponse userModel) async {
    await Future.wait([
      storage.writeString(key: MqAuthStatics.localeKey, value: userModel.localeCode),
      storage.writeString(key: MqAuthStatics.genderKey, value: userModel.gender.name),
      storage.writeString(key: MqAuthStatics.usernameKey, value: userModel.username),
    ]);
  }

  @override
  Future<void> saveGender(Gender gender) {
    return storage.writeString(key: MqAuthStatics.genderKey, value: gender.name);
  }

  @override
  Future<void> saveLocaleCode(String localeCode) {
    return storage.writeString(key: MqAuthStatics.localeKey, value: localeCode);
  }

  @override
  Future<void> deleteAccountLocal() async {
    await storage.clear();
    await storage.delete(key: MqAuthStatics.tokenKey);
  }

  @override
  Future<void> logoutLocal() async {
    await storage.clear();
  }
}

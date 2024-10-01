import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class AuthLocalDataSourceMock implements AuthLocalDataSource {
  const AuthLocalDataSourceMock();

  @override
  UserEntity? get init => null;

  @override
  String? getToken() => '';

  @override
  Future<void> saveUserData(UserEntity userEntity) async {}

  @override
  Future<void> saveGender(Gender gender) => Future.value();

  @override
  Future<void> saveLocaleCode(String localeCode) => Future.value();

  @override
  Future<void> logoutLocal() async => Future.value();

  @override
  Future<void> deleteAccountLocal() async => Future.value();
}

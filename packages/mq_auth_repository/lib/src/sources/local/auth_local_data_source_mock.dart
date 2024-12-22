import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

@immutable
final class AuthLocalDataSourceMock implements AuthLocalDataSource {
  const AuthLocalDataSourceMock();

  @override
  UserEntity? get init => null;

  @override
  String? getToken() => '';

  @override
  Future<void> saveUserData(UserEntity userEntity) => Future.value();

  @override
  Future<void> saveGender(Gender gender) => Future.value();

  @override
  Future<void> saveLocaleCode(String localeCode) => Future.value();

  @override
  Future<void> deleteAccountLocal() => Future.value();

  @override
  Future<void> logoutLocal() => Future.value();
}

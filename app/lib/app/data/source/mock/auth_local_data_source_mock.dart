import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class AuthLocalDataSourceMock implements AuthLocalDataSource {
  const AuthLocalDataSourceMock();

  @override
  UserEntity? get init {
    return null;
  }

  @override
  String? getToken() => '';

  @override
  Future<void> saveUserData(UserEntity userEntity) async {}

  @override
  Future<void> saveGender(Gender gender) {
    return Future.value();
  }

  @override
  Future<void> saveLocaleCode(String localeCode) {
    return Future.value();
  }

  @override
  Future<void> logoutLocal() async {
    return Future.value();
  }
}

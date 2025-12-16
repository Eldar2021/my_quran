import 'package:mq_auth_repository/mq_auth_repository.dart';

abstract class AuthLocalDataSource {
  UserModel? get init;

  String? getToken();

  Future<void> saveUserData(UserModel userModel);

  Future<void> saveGender(Gender gender);

  Future<void> saveLocaleCode(String localeCode);

  Future<void> deleteAccountLocal();

  Future<void> logoutLocal();
}

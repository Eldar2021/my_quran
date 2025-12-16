import 'package:mq_auth_repository/mq_auth_repository.dart';

abstract class AuthLocalDataSource {
  UserTokenModel? get init;

  String? getToken();

  Future<void> saveUserData(UserTokenModel userModel);

  Future<void> saveGender(Gender gender);

  Future<void> saveLocaleCode(String localeCode);

  Future<void> deleteAccountLocal();

  Future<void> logoutLocal();
}

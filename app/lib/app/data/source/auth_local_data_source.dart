import 'package:my_quran/app/app.dart';

abstract class AuthLocalDataSource {
  UserEntity? get init;
  String? getToken();
  Future<void> saveUserData(UserEntity userEntity);
  Future<void> saveGender(Gender gender);
  Future<void> saveLocaleCode(String localeCode);
  Future<void> deleteAccountLocal();
  Future<void> logoutLocal();
}

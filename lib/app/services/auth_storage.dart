import 'package:shared_preferences/shared_preferences.dart';

import 'package:hatim/models/models.dart';

class AuthStorage {
  const AuthStorage(this.storage);

  final SharedPreferences storage;

  static const String _token = 'token';
  static const String _gender = 'gender';

  User? init() {
    final userToken = storage.getString(_token);
    final userGender = storage.getString(_gender);
    if (userToken != null && userGender != null) {
      return User(token: token, gender: gender == Gender.male.name ? Gender.male : Gender.female);
    } else {
      return null;
    }
  }

  Future<void> login(User user) async {
    await storage.remove(_token);
    await storage.remove(_gender);
    await storage.setString(_token, user.token);
    await storage.setString(_gender, user.gender.name);
  }

  Future<void> logout() async {
    await storage.remove(_token);
    await storage.remove(_gender);
  }

  String get token => _token;

  String get gender => _gender;
}

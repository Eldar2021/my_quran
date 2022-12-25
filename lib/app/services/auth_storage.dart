import 'package:hatim/core/core.dart';

import 'package:hatim/models/models.dart';

class AuthStorage {
  const AuthStorage(this.storage);

  final AppCache<String> storage;

  static const String _token = 'token';
  static const String _gender = 'gender';

  User? init() {
    final userToken = storage.read(key: _token);
    final userGender = storage.read(key: _gender);
    if (userToken != null && userGender != null) {
      return User(token: token, gender: userGender == Gender.male.name ? Gender.male : Gender.female);
    } else {
      return null;
    }
  }

  Future<void> login(User user) async {
    await storage.save(key: _token, value: user.token);
    await storage.save(key: _gender, value: user.gender.name);
  }

  Future<void> changeGender(Gender gender) async {
    await storage.save(key: _gender, value: gender.name);
  }

  Future<void> logout() async => storage.clear();

  String get token => _token;

  String get gender => _gender;
}

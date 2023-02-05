import 'package:dartz/dartz.dart';
import 'package:hatim/constants/contants.dart';
import 'package:hatim/core/core.dart';
import 'package:hatim/models/models.dart';

class AuthService {
  const AuthService(this.storage, this.client);

  final AppCache<String> storage;
  final RemoteClient client;

  static const String _token = 'token';
  static const String _gender = 'gender';
  static const String _username = 'username';
  static const String _totalHatim = 'total_hatim';
  static const String _totalRead = 'total_read';

  User? init() {
    final userToken = storage.read(key: _token);
    final userGender = storage.read(key: _gender);
    final username = storage.read(key: _username);
    if (userToken != null && userGender != null && username != null) {
      return User(
        accessToken: userToken,
        username: username,
        gender: userGender == Gender.male.name ? Gender.male : Gender.female,
      );
    } else {
      return null;
    }
  }

  String? getToken() => storage.read(key: _token);

  Future<Either<Exception, User>> login(String languageCode, Gender gender) async {
    final user = await client.post<User>(
      ApiConst.signUp,
      fromJson: User.fromJson,
      body: <String, dynamic>{
        'gender': gender.name.toUpperCase(),
        'languageCode': languageCode,
      },
    );

    return user.fold(
      Left.new,
      (r) async {
        final user = r.copyWith(gender: gender);
        await storage.save(key: _token, value: user.accessToken);
        await storage.save(key: _gender, value: user.gender!.name);
        await storage.save(key: _username, value: user.username);
        return Right(user);
      },
    );
  }

  Future<void> changeGender(Gender gender) async {
    await storage.save(key: _gender, value: gender.name);
  }

  int? getTotalHatim() {
    final value = storage.read(key: _totalHatim);
    return value != null ? int.parse(value) : null;
  }

  int? getTotalRead() {
    final value = storage.read(key: _totalRead);
    return value != null ? int.parse(value) : null;
  }

  Future<void> saveTotalHatim(String value) async {
    await storage.save(key: _totalHatim, value: value);
  }

  Future<void> saveTotalRead(String value) async {
    await storage.save(key: _totalRead, value: value);
  }

  Future<void> logout() async => storage.clear();

  String get token => _token;
  String get gender => _gender;
  String get totalHatim => _totalHatim;
  String get totalRead => _totalRead;
  String get username => _username;
}

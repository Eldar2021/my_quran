import 'package:my_quran/core/core.dart';
import 'package:my_quran/models/models.dart';

abstract class AuthRepository {
  User? get init;
  Future<Either<User, Exception>> login(String languageCode, Gender gender);
  Future<void> saveGender(Gender gender);
}

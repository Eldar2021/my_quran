import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/models/models.dart';

@immutable
final class LoginUseCase {
  const LoginUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<User, Exception>> login(String languageCode, Gender gender) async {
    return repository.login(languageCode, gender);
  }
}

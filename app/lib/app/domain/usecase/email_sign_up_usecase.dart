import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';

@immutable
final class EmailSignUpUseCase {
  const EmailSignUpUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<UserEntity, Exception>> call(
    String email,
    String password,
    String languageCode,
    Gender gender,
  ) {
    return repository.signUpWithEmail(email, password, languageCode, gender);
  }
}

import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';

@immutable
final class EmailSignUpUseCase {
  const EmailSignUpUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<UserEntity, Exception>> call({
    required String email,
    required String password,
    required String username,
    required String languageCode,
    required Gender gender,
  }) {
    return repository.signUpWithEmail(
      email: email,
      password: password,
      username: username,
      languageCode: languageCode,
      gender: gender,
    );
  }
}

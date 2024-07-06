import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';

@immutable
final class EmailSignInUseCase {
  const EmailSignInUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<UserEntity, Exception>> call({
    required String email,
    required String password,
    required String languageCode,
    required Gender gender,
  }) {
    return repository.signInWithEmail(
      email: email,
      password: password,
      languageCode: languageCode,
      gender: gender,
    );
  }
}

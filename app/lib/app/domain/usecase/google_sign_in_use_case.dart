import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';

@immutable
final class GoogleSignInUseCase {
  const GoogleSignInUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<UserEntity, Exception>> call(
    String languageCode,
    Gender gender,
  ) {
    return repository.signWithGoogle(languageCode, gender);
  }
}

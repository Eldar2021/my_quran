import 'package:meta/meta.dart';
import 'package:mq_either/mq_either.dart';
import 'package:my_quran/app/app.dart';

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

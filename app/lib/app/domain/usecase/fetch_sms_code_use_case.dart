import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';

@immutable
final class FetchSmsCodeUseCase {
  const FetchSmsCodeUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<UserEntity, Exception>> call({
    required String code,
    required String languageCode,
    required Gender gender,
  }) {
    return repository.fetchSmsCode(
      code: code,
      languageCode: languageCode,
      gender: gender,
    );
  }
}

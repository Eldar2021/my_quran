import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class FetchSmsCodeUseCase {
  const FetchSmsCodeUseCase(this.repository);

  final AuthRepository repository;

  Future<void> call({
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

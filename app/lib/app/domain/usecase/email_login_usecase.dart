import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class EmailLoginUseCase {
  const EmailLoginUseCase(this.repository);

  final AuthRepository repository;

  Future<void> call(String email) {
    return repository.loginWithEmail(email);
  }
}

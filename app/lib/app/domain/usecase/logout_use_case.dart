import 'package:flutter/foundation.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class LogoutUseCase {
  const LogoutUseCase(this.repository);

  final AuthRepository repository;

  Future<void> call() {
    return repository.logout();
  }
}

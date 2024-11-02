import 'package:flutter/foundation.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class DeleteAccountUseCase {
  const DeleteAccountUseCase(this.repository);

  final AuthRepository repository;

  Future<void> call() {
    return repository.deleteAccount();
  }
}

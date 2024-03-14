import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/models/models.dart';

@immutable
final class GetInitialUserUseCase {
  const GetInitialUserUseCase(this.repository);

  final AuthRepository repository;

  User? get init {
    return repository.init;
  }
}

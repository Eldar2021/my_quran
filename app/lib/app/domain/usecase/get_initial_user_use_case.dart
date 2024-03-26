import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class GetInitialUserUseCase {
  const GetInitialUserUseCase(this.repository);

  final AuthRepository repository;

  UserEntity? get init {
    return repository.init;
  }
}

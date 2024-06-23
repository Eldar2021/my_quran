import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class SerUserDataUseCase {
  const SerUserDataUseCase(this.repository);

  final AuthRepository repository;

  Future<void> call(UserEntity userEntity) {
    return repository.setUserData(userEntity);
  }
}

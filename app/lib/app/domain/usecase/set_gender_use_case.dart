import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class SetGenderUseCase {
  const SetGenderUseCase(this.repository);

  final AuthRepository repository;

  Future<void> call(Gender gender) async {
    return repository.saveGender(gender);
  }
}

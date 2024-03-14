import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/models/models.dart';

@immutable
final class SetGenderUseCase {
  const SetGenderUseCase(this.repository);

  final AuthRepository repository;

  Future<void> saveGender(Gender gender) async {
    return repository.saveGender(gender);
  }
}

import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/core/core.dart';

@immutable
final class PatchGenderUseCase {
  const PatchGenderUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<UserDataEntity, Exception>> call({
    required String userId,
    required Gender gender,
  }) {
    return repository.patchGender(userId: userId, gender: gender);
  }
}

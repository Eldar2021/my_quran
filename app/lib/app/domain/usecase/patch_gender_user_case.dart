import 'package:meta/meta.dart';
import 'package:mq_either/mq_either.dart';
import 'package:my_quran/app/app.dart';

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

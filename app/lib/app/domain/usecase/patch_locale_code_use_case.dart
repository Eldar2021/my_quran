import 'package:meta/meta.dart';
import 'package:mq_either/mq_either.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class PatchLocaleCodeUseCase {
  const PatchLocaleCodeUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<UserDataEntity, Exception>> call({
    required String userId,
    required String localeCode,
  }) {
    return repository.patchLocaleCode(
      userId: userId,
      localeCode: localeCode,
    );
  }
}

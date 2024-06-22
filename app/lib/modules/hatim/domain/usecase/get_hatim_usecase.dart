import 'package:flutter/foundation.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class GetHatimUseCase {
  const GetHatimUseCase(this.repository);

  final HatimReadRepository repository;

  Future<Either<HatimReadEntity, Exception>> execute(String token) {
    return repository.getHatim(token);
  }
}

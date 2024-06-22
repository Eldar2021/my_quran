import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

abstract class HatimReadRepository {
  Future<Either<HatimReadEntity, Exception>> getHatim(String token);
}

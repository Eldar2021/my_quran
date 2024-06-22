import 'package:flutter/foundation.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class HatimReadRepositoryImpl implements HatimReadRepository {
  const HatimReadRepositoryImpl({required this.remoteDataSource});

  final HatimRemoteDataSource remoteDataSource;

  @override
  Future<Either<HatimReadEntity, Exception>> getHatim(String token) async {
    final res = await remoteDataSource.getHatim(token);
    return res.fold(Left.new, (r) async {
      final entity = HatimReadEntity(id: r.id, status: r.status, type: r.type);
      return Right(entity);
    });
  }
}

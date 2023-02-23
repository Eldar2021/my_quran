import 'package:dartz/dartz.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/models/models.dart';

class HatimReadService {
  const HatimReadService(this.client);

  final RemoteClient client;

  Future<Either<Exception, HatimReadModel>> getHatim(String token) async {
    return client.get(
      ApiConst.hatim,
      fromJson: HatimReadModel.fromJson,
      token: token,
    );
  }
}

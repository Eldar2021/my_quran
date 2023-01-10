import 'package:dartz/dartz.dart';
import 'package:hatim/constants/contants.dart';
import 'package:hatim/core/core.dart';
import 'package:hatim/models/models.dart';

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

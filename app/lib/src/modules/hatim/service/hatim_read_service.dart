

import 'package:my_quran/src/src.dart';

class HatimReadService {
  const HatimReadService(this.client);

  final RemoteClient client;

  Future<Either<HatimReadModel, Exception>> getHatim(String token) async {
    return client.get(apiConst.hatim, fromJson: HatimReadModel.fromJson, token: token);
  }
}

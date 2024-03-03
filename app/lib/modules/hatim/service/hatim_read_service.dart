import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

class HatimReadService {
  const HatimReadService(this.client);

  final RemoteClient client;

  Future<Either<HatimReadModel, Exception>> getHatim(String token) async {
    return client.get(apiConst.hatim, fromJson: HatimReadModel.fromJson, token: token);
  }
}

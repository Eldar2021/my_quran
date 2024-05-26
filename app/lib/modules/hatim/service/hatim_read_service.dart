import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/models/models.dart';

class HatimReadService {
  const HatimReadService(this.client);

  final RemoteClient client;

  Future<Either<HatimReadModel, Exception>> getHatim(String token) {
    return client.post(
      apiConst.joinToHatim,
      fromJson: HatimReadModel.fromJson,
      token: token,
    );
  }
}

import 'package:hatim/constants/contants.dart';
import 'package:hatim/core/core.dart';
import 'package:hatim/models/models.dart';

class HatimReadService {
  const HatimReadService(this.client);

  final RemoteClient client;

  Future<HatimReadModel?> getHatim(String token) async {
    final hatim = await client.get(
      ApiConst.hatim,
      fromJson: HatimReadModel.fromJson,
      token: token,
    );

    return hatim.fold((l) => null, (r) => r);
  }
}

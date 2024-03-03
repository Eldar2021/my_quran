import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

class HomeRemoteDataSource {
  const HomeRemoteDataSource(this.remoteClient);
  final RemoteClient remoteClient;

  Future<HomeModel> getRemoteData(String token) async {
    final remoteValue = await remoteClient.get<HomeModel>(
      apiConst.home,
      fromJson: HomeModel.fromJson,
      token: token,
    );
    return remoteValue.fold(
      (left) {
        throw Exception('Failed to fetch remote data');
      },
      (right) => right,
    );
  }
}

import 'dart:convert';

import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/models/models.dart';

class HomeService {
  const HomeService(this.localClient, this.remoteClient);

  final LocalClient<String> localClient;
  final RemoteClient remoteClient;

  Future<HomeModel> getData(String token) async {
    const key = 'home-model';
    final remoteValue = await remoteClient.get<HomeModel>(
      ApiConst.home,
      fromJson: HomeModel.fromJson,
      token: token,
    );
    return remoteValue.fold(
      (l) async {
        final localvalue = localClient.read(key: key);
        if (localvalue != null) {
          final data = jsonDecode(localvalue);
          return HomeModel.fromJson(data as Map<String, dynamic>);
        } else {
          return const HomeModel(allDoneHatims: 0, allDonePages: 0, donePages: 0);
        }
      },
      (r) async {
        await localClient.save(key: key, value: jsonEncode(r.toJson()));
        return r;
      },
    );
  }
}

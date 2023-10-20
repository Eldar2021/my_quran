import 'dart:convert';

import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/models/models.dart';

class HomeService {
  const HomeService(this.storage, this.remoteClient);

  final PreferencesStorage storage;
  final RemoteClient remoteClient;

  Future<HomeModel> getData(String token) async {
    const key = 'home-model';
    final remoteValue = await remoteClient.get<HomeModel>(
      apiConst.home,
      fromJson: HomeModel.fromJson,
      token: token,
    );
    return remoteValue.fold(
      (l) async {
        final localvalue = storage.readString(key: key);
        if (localvalue != null) {
          final data = jsonDecode(localvalue);
          return HomeModel.fromJson(data as Map<String, dynamic>);
        } else {
          return const HomeModel(allDoneHatims: 0, allDonePages: 0, donePages: 0);
        }
      },
      (r) async {
        await storage.writeString(key: key, value: jsonEncode(r.toJson()));
        return r;
      },
    );
  }
}

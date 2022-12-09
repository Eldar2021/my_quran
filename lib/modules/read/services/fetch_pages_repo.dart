import 'dart:convert';

import 'package:hatim/constants/contants.dart';
import 'package:hatim/core/core.dart';
import 'package:hatim/models/models.dart';

class FetchPageRepo {
  const FetchPageRepo(this.remoteClient, this.localClient);

  final RemoteClient remoteClient;
  final LocalClient<String> localClient;

  Future<List<Verse>?> gerVerses(int page) async {
    final key = 'quran-$page';
    final localvalue = localClient.read(key: key);
    if (localvalue != null) {
      final listString = jsonDecode(localvalue) as List;
      return listString.map((e) => Verse.fromMap(e as Map<String, dynamic>)).toList();
    } else {
      final remoteValue = await remoteClient.getVerses(ApiConst.verse(page));
      await localClient.save(key: key, value: jsonEncode(remoteValue));
      return remoteValue?.map((e) => Verse.fromMap(e as Map<String, dynamic>)).toList();
    }
  }
}

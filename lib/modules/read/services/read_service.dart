import 'dart:convert';

import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/models/models.dart';

class ReadService {
  const ReadService(this.remoteClient, this.localClient);

  final RemoteClient remoteClient;
  final LocalClient<String> localClient;

  Future<QuranPage?> gerVerses(int page) async {
    final key = 'quran-$page';
    final localvalue = localClient.read(key: key);
    if (localvalue != null) {
      final data = jsonDecode(localvalue);
      return QuranPage.fromJson(data as Map<String, dynamic>);
    } else {
      final remoteValue = await remoteClient.get<QuranPage>(
        ApiConst.verse(page),
        fromJson: QuranPage.fromJson,
      );

      return remoteValue.fold(
        (l) => null,
        (r) async {
          await localClient.save(key: key, value: jsonEncode(r.toJson()));
          return r;
        },
      );
    }
  }
}

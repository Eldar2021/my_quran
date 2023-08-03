import 'dart:convert';

import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/models/models.dart';

class ReadService {
  const ReadService(this.remoteClient, this.storage);

  final RemoteClient remoteClient;
  final PreferencesStorage storage;

  Future<QuranPage?> gerVerses(int page, String quranFmt) async {
    final key = 'quran-$quranFmt-$page';
    final localvalue = storage.readString(key: key);
    if (localvalue != null) {
      final data = jsonDecode(localvalue);
      return QuranPage.fromJson(data as Map<String, dynamic>);
    } else {
      final remoteValue = await remoteClient.get<QuranPage>(
        ApiConst.verse(page, quranFmt),
        fromJson: QuranPage.fromJson,
      );

      return remoteValue.fold(
        (l) => null,
        (r) async {
          await storage.writeString(key: key, value: jsonEncode(r.toJson()));
          return r;
        },
      );
    }
  }
}

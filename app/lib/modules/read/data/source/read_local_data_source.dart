import 'dart:convert';

import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/modules/modules.dart';

class ReadLocalDataSource {
  const ReadLocalDataSource(this.storage);

  final PreferencesStorage storage;

  Future<QuranPage?> getPage(int page, String quranFmt) async {
    final key = 'quran-$quranFmt-$page';
    final localValue = storage.readString(key: key);

    if (localValue != null) {
      final data = jsonDecode(localValue);
      return QuranPage.fromJson(data as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> cachePage(int page, String quranFmt, QuranPage pageData) async {
    final key = 'quran-$quranFmt-$page';
    await storage.writeString(key: key, value: jsonEncode(pageData.toJson()));
  }
}

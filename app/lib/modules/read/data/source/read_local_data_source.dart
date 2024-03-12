import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class ReadLocalDataSource {
  const ReadLocalDataSource(this.storage);

  final PreferencesStorage storage;

  QuranPageResponse? getPage(int page, String quranFmt) {
    final key = 'quran-$quranFmt-$page';
    final localValue = storage.readString(key: key);

    if (localValue != null) {
      final data = jsonDecode(localValue);
      return QuranPageResponse.fromJson(data as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> cachePage(int page, String quranFmt, QuranPageResponse pageData) async {
    final key = 'quran-$quranFmt-$page';
    await storage.writeString(key: key, value: jsonEncode(pageData.toJson()));
  }
}

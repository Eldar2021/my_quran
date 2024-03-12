import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class LocalThemeDataSource {
  const LocalThemeDataSource(this.storage);

  final PreferencesStorage storage;

  ReadThemeState get initialTheme {
    final value = storage.readString(key: StorageKeys.readThemeKey);
    return value != null ? ReadThemeState.fromJson(json.decode(value) as Map<String, dynamic>) : const ReadThemeState();
  }

  Future<void> saveThemeState(ReadThemeState themeState) async {
    final value = json.encode(themeState.toJson());
    await storage.writeString(key: StorageKeys.readThemeKey, value: value);
  }
}

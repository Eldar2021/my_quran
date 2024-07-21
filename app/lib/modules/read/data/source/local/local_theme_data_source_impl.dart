import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class LocalThemeDataSourceImpl implements LocalThemeDataSource {
  const LocalThemeDataSourceImpl(this.storage);

  final PreferencesStorage storage;

  @override
  ReadThemeState get initialTheme {
    final value = storage.readString(key: StorageKeys.readThemeKey);
    return value != null ? ReadThemeState.fromJson(json.decode(value) as Map<String, dynamic>) : const ReadThemeState();
  }

  @override
  Future<void> saveThemeState(ReadThemeState themeState) async {
    final value = json.encode(themeState.toJson());
    await storage.writeString(key: StorageKeys.readThemeKey, value: value);
  }
}

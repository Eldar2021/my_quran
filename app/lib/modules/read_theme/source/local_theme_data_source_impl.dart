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
  ReadThemeData getInitialThemeState() {
    final value = storage.readString(key: StorageKeys.readThemeKey);
    if (value == null) return ReadThemeData.initial;
    return ReadThemeData.fromJson(json.decode(value) as Map<String, dynamic>);
  }

  @override
  Future<void> saveThemeState(ReadThemeData themeState) async {
    final value = json.encode(themeState.toJson());
    await storage.writeString(key: StorageKeys.readThemeKey, value: value);
  }
}

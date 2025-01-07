import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_storage/mq_storage.dart';

@immutable
final class LocalThemeDataSourceImpl implements LocalThemeDataSource {
  const LocalThemeDataSourceImpl(this.storage);

  final PreferencesStorage storage;

  static const _readThemeKey = 'readThemeKey';

  @override
  ReadThemeData getInitialThemeState() {
    final value = storage.readString(key: _readThemeKey);
    if (value == null) return ReadThemeData.initial;
    return ReadThemeData.fromJson(json.decode(value) as Map<String, dynamic>);
  }

  @override
  Future<void> saveThemeState(ReadThemeData themeState) async {
    final value = json.encode(themeState.toJson());
    await storage.writeString(key: _readThemeKey, value: value);
  }
}

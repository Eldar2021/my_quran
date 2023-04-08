import 'dart:convert';

import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/modules/read/logic/read_theme_cubit.dart';

class ReadThemeService {
  const ReadThemeService(this.storage);

  final PreferencesStorage storage;

  ReadThemeState init() {
    final value = storage.readString(key: AppConst.readThemeKey);
    if (value != null) {
      final data = json.decode(value) as Map<String, dynamic>;
      return ReadThemeState.fromJson(data);
    } else {
      return const ReadThemeState();
    }
  }

  Future<void> saveChanges(ReadThemeState theme) async {
    final value = json.encode(theme.toJson());
    await storage.writeString(key: AppConst.readThemeKey, value: value);
  }
}

import 'dart:convert';

import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/modules/read/logic/read_theme_cubit.dart';

class ReadThemeService {
  const ReadThemeService(this.storage);

  final PreferencesStorage storage;

  ReadThemeState get init {
    final value = storage.readString(key: AppConst.readThemeKey);
    return value != null ? ReadThemeState.fromJson(json.decode(value) as Map<String, dynamic>) : const ReadThemeState();
  }

  Future<void> saveChanges(ReadThemeState theme) async {
    final value = json.encode(theme.toJson());
    await storage.writeString(key: AppConst.readThemeKey, value: value);
  }
}

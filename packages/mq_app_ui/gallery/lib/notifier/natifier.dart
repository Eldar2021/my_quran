import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_storage/mq_storage.dart';

enum MqAppUiType {
  orange,
  orangeDark,
  blue,
  blueDark;

  factory MqAppUiType.fromString(String? value) {
    return switch (value) {
      'orange' => MqAppUiType.orange,
      'orangeDark' => MqAppUiType.orangeDark,
      'blue' => MqAppUiType.blue,
      'blueDark' => MqAppUiType.blueDark,
      _ => MqAppUiType.orange,
    };
  }
}

class MqAppUiNotifier extends ChangeNotifier {
  MqAppUiNotifier(this.storage);

  final PreferencesStorage storage;

  static const _themeKey = 'theme-key';

  MqAppUiType _themeType = MqAppUiType.orange;
  MqAppUiType get themeType => _themeType;

  void init() {
    try {
      final value = storage.readString(key: _themeKey);
      _themeType = MqAppUiType.fromString(value);
      notifyListeners();
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> changeTheme(MqAppUiType type) async {
    try {
      _themeType = type;
      await storage.writeString(key: _themeKey, value: _themeType.name);
      notifyListeners();
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  AppTheme get theme {
    return switch (_themeType) {
      MqAppUiType.orange => const AppOrangeTheme(),
      MqAppUiType.orangeDark => const AppOrangeDarkTheme(),
      MqAppUiType.blue => const AppBlueTheme(),
      MqAppUiType.blueDark => const AppBlueDarkTheme(),
    };
  }
}

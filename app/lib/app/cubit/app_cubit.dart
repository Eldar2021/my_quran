import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_theme/mq_app_theme.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_storage/mq_storage.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this.appThemeRepository)
      : super(
          AppState(
            appThemeRepository.getInitialThemeState(),
            appThemeRepository.appVersion(),
          ),
        );

  final AppRepository appThemeRepository;

  Future<void> changeMode({required bool isDark}) async {
    await appThemeRepository.saveThemeMode(isDark: isDark);
    emit(
      state.copyWith(
        theme: state.theme.copyWith(
          brightness: isDark ? Brightness.dark : Brightness.light,
        ),
      ),
    );
  }

  Future<void> changeColor(int index, Color color) async {
    await appThemeRepository.saveThemePrimaryColor(index);
    emit(state.copyWith(theme: state.theme.copyWith(targetColor: color)));
  }
}

class AppThemeCubit extends Cubit<AppTheme> {
  AppThemeCubit(this.storage) : super(const AppOrangeTheme());

  final PreferencesStorage storage;

  static const _themeKey = 'theme-key';

  MqAppUiType _themeType = MqAppUiType.orange;

  void init() {
    try {
      final value = storage.readString(key: _themeKey);
      _themeType = MqAppUiType.fromString(value);
      emit(theme);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> changeTheme({bool isOrange = false}) async {
    try {
      final brightness = theme.themeData.brightness;
      final type = switch (brightness) {
        Brightness.light => isOrange ? MqAppUiType.orange : MqAppUiType.blue,
        Brightness.dark => isOrange ? MqAppUiType.orangeDark : MqAppUiType.blueDark,
      };

      _themeType = type;
      await storage.writeString(
        key: _themeKey,
        value: _themeType.name,
      );
      emit(theme);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> changeMode({bool isDark = false}) async {
    try {
      final type = switch (_themeType) {
        MqAppUiType.orange || MqAppUiType.orangeDark => isDark ? MqAppUiType.orangeDark : MqAppUiType.orange,
        MqAppUiType.blue || MqAppUiType.blueDark => isDark ? MqAppUiType.blueDark : MqAppUiType.blue,
      };
      _themeType = type;
      await storage.writeString(
        key: _themeKey,
        value: _themeType.name,
      );
      emit(theme);
    } catch (e) {
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

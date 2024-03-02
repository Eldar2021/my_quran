import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/theme/theme.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(
    this.localService,
    this.themeService,
  ) : super(AppState(localService.init, themeService.init));

  final AppService localService;
  final ThemeService themeService;

  Future<void> changeLang(String langKey) async {
    final local = await localService.setLocale(langKey);
    emit(state.copyWith(currentLocale: local));
  }

  Future<void> changeMode({required bool isDark}) async {
    await themeService.setMode(isDark: isDark);
    emit(state.copyWith(theme: state.theme.copyWith(brightness: isDark ? Brightness.dark : Brightness.light)));
  }

  Future<void> changeColor(int index, Color color) async {
    await themeService.setColor(index);
    emit(state.copyWith(theme: state.theme.copyWith(targetColor: color)));
  }

  Future<void> changeGender(Gender gender) async {
    emit(state.copyWith(gender: gender));
  }
}

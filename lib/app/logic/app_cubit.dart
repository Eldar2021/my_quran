import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/theme/custom/custom_theme.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(
    this.localService,
    this.themeService,
  ) : super(AppState(localService.init(), themeService.init()));

  final LocalService localService;
  final ThemeService themeService;

  Future<void> changeLang(int index) async {
    final local = await localService.setLocale(index);
    emit(state.copyWith(currentLocale: local));
  }

  Future<void> changeMode({required bool isDark}) async {
    await themeService.setMode(isDark: isDark);
    emit(state.copyWith(theme: state.theme.copyWith(brightness: isDark ? Brightness.dark : Brightness.light)));
  }

  Future<void> changeColor(Color color) async {
    await themeService.setColor(color);
    emit(state.copyWith(theme: state.theme.copyWith(targetColor: color)));
  }
}

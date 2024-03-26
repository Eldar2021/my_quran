import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/theme/custom/custom_theme.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required this.getLocalLocaleUseCase,
    required this.setLocaleUseCase,
    required this.getInitialThemeUseCase,
    required this.setModeUseCase,
    required this.setColorUseCase,
  }) : super(AppState(getLocalLocaleUseCase.getCurrentLocale, getInitialThemeUseCase.call));

  final GetCurrentLocaleUseCase getLocalLocaleUseCase;
  final SetLocaleUseCase setLocaleUseCase;
  final GetAppInitialThemeUseCase getInitialThemeUseCase;
  final SetModeUseCase setModeUseCase;
  final SetColorUseCase setColorUseCase;

  Future<void> changeLang(String langKey) async {
    final local = await setLocaleUseCase.setLocal(langKey);
    emit(state.copyWith(currentLocale: local));
  }

  Future<void> changeMode({required bool isDark}) async {
    await setModeUseCase.setMode(isDark: isDark);
    emit(state.copyWith(theme: state.theme.copyWith(brightness: isDark ? Brightness.dark : Brightness.light)));
  }

  Future<void> changeColor(int index, Color color) async {
    await setColorUseCase.setColor(index, color);
    emit(state.copyWith(theme: state.theme.copyWith(targetColor: color)));
  }

  Future<void> changeGender(Gender gender) async {
    emit(state.copyWith(gender: gender));
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/theme/custom/custom_theme.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required this.getInitialThemeUseCase,
    required this.setModeUseCase,
    required this.setColorUseCase,
    required this.getAppVersionUseCase,
  }) : super(
          AppState(
            getInitialThemeUseCase.call,
            getAppVersionUseCase.call,
          ),
        );

  final GetAppInitialThemeUseCase getInitialThemeUseCase;
  final SetModeUseCase setModeUseCase;
  final SetColorUseCase setColorUseCase;
  final GetAppVersionUseCase getAppVersionUseCase;

  Future<void> changeMode({required bool isDark}) async {
    await setModeUseCase(isDark: isDark);
    emit(
      state.copyWith(
        theme: state.theme.copyWith(
          brightness: isDark ? Brightness.dark : Brightness.light,
        ),
      ),
    );
  }

  Future<void> changeColor(int index, Color color) async {
    await setColorUseCase(index, color);
    emit(state.copyWith(theme: state.theme.copyWith(targetColor: color)));
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_theme/mq_app_theme.dart';

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

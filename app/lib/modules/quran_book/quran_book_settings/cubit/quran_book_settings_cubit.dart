import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

part 'quran_book_settings_state.dart';

class QuranBookSettingsCubit extends Cubit<QuranBookSettingsState> {
  QuranBookSettingsCubit(this.repository) : super(const QuranBookSettingsState());

  final ReadThemeRepository repository;

  void init() {
    final data = repository.getInitialThemeState();
    emit(
      QuranBookSettingsState(
        modeIndex: data.modeIndex == 0 ? 0 : 1,
        verticalSpaceSize: data.verticalSpaceSize,
        horizontalSpaceSize: data.horizontalSpaceSize,
        textSize: data.textSize,
      ),
    );
  }

  void changeMode(int index) {
    emit(state.copyWith(modeIndex: index));
  }

  void changeTextSize(double size) {
    emit(state.copyWith(textSize: size));
  }

  void changeVerticalSpace(double space) {
    emit(state.copyWith(verticalSpaceSize: space));
  }

  void changeHorizontalSpace(double space) {
    emit(state.copyWith(horizontalSpaceSize: space));
  }

  Future<void> saveChanges() async {
    final date = ReadThemeData(
      modeIndex: state.modeIndex,
      verticalSpaceSize: state.verticalSpaceSize,
      horizontalSpaceSize: state.horizontalSpaceSize,
      textSize: state.textSize,
    );
    await repository.saveThemeState(date);
  }
}

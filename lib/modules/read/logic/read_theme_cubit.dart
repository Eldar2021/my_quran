import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'read_theme_state.dart';

class ReadThemeCubit extends Cubit<ReadThemeState> {
  ReadThemeCubit() : super(const ReadThemeState(ReadTheme()));

  void changeMode(int index) {
    emit(ReadThemeState(state.theme.copyWith(modeIndex: index)));
  }

  void changeTextSize(int size) {
    emit(ReadThemeState(state.theme.copyWith(textSize: size)));
  }

  void changeVerticalSpace(int space) {
    emit(ReadThemeState(state.theme.copyWith(verticalSpace: space)));
  }

  void changeHorizontalSpace(int space) {
    emit(ReadThemeState(state.theme.copyWith(horizontalSpace: space)));
  }
}

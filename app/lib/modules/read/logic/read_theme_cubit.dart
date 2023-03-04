import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/modules/modules.dart';

part 'read_theme_state.dart';

class ReadThemeCubit extends Cubit<ReadThemeState> {
  ReadThemeCubit(this.service) : super(ReadThemeState(service.init()));

  final ReadThemeService service;

  void changeMode(int index) {
    emit(ReadThemeState(state.theme.copyWith(modeIndex: index)));
  }

  void changeTextSize(int size) {
    emit(ReadThemeState(state.theme.copyWith(textSize: size)));
  }

  void changeVerticalSpace(int space) {
    emit(ReadThemeState(state.theme.copyWith(verticalSpaceSize: space)));
  }

  void changeHorizontalSpace(int space) {
    emit(ReadThemeState(state.theme.copyWith(horizontalSpaceSize: space)));
  }

  Future<void> saveChanges() async {
    await service.saveChanges(state.theme);
  }
}

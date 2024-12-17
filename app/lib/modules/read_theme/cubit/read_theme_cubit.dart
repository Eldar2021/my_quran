import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

part 'read_theme_state.dart';

class ReadThemeCubit extends Cubit<ReadThemeState> {
  ReadThemeCubit({required this.readThemeRepository}) : super(const ReadThemeState());

  final ReadThemeRepository readThemeRepository;

  void initializeTheme() {
    emit(readThemeRepository.getInitialThemeState);
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
    await readThemeRepository.saveThemeState(state);
  }
}

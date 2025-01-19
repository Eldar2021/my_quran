import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

part 'read_theme_state.dart';

class ReadThemeCubit extends Cubit<ReadThemeState> {
  ReadThemeCubit({
    required this.readThemeRepository,
  }) : super(const ReadThemeState());

  final ReadThemeRepository readThemeRepository;

  void initializeTheme() {
    final data = readThemeRepository.getInitialThemeState();
    emit(
      ReadThemeState(
        modeIndex: data.modeIndex,
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
    await readThemeRepository.saveThemeState(date);
  }
}

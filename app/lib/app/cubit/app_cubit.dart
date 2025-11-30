import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class AppThemeCubit extends Cubit<AppTheme> {
  AppThemeCubit(this.appThemeRepository) : super(appThemeRepository.getInitialThemeState());

  final AppRepository appThemeRepository;

  Future<void> changeColor({required bool isOrange}) async {
    await appThemeRepository.saveThemePrimaryColor(isOrange: isOrange);
    if (isOrange) {
      emit(state.isDark ? const AppOrangeDarkTheme() : const AppOrangeTheme());
    } else {
      emit(state.isDark ? const AppBlueDarkTheme() : const AppBlueTheme());
    }
  }

  Future<void> changeMode({required bool isDark}) async {
    await appThemeRepository.saveThemeMode(isDark: isDark);
    if (isDark) {
      emit(
        state.isOrange ? const AppOrangeDarkTheme() : const AppBlueDarkTheme(),
      );
    } else {
      emit(state.isOrange ? const AppOrangeTheme() : const AppBlueTheme());
    }
  }
}

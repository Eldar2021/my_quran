part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState(this.currentLocale, this.theme);

  final Locale currentLocale;
  final CustomTheme theme;

  @override
  List<Object?> get props => [currentLocale, theme];

  AppState copyWith({Locale? currentLocale, CustomTheme? theme}) {
    return AppState(
      currentLocale ?? this.currentLocale,
      theme ?? this.theme,
    );
  }
}

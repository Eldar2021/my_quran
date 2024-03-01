part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState(
    this.currentLocale,
    this.theme, {
    this.gender = Gender.male,
  });

  final Locale currentLocale;
  final CustomTheme theme;
  final Gender gender;

  @override
  List<Object?> get props => [currentLocale, theme, gender];

  AppState copyWith({Locale? currentLocale, CustomTheme? theme, Gender? gender}) {
    return AppState(
      currentLocale ?? this.currentLocale,
      theme ?? this.theme,
      gender: gender ?? this.gender,
    );
  }
}

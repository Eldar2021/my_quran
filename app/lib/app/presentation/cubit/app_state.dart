part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState(
    this.currentLocale,
    this.theme,
    this.appVersion, {
    this.gender = Gender.male,
  });

  final Locale currentLocale;
  final CustomTheme theme;
  final Gender gender;
  final String appVersion;

  @override
  List<Object?> get props => [
        currentLocale,
        theme,
        gender,
        appVersion,
      ];

  AppState copyWith({
    Locale? currentLocale,
    CustomTheme? theme,
    Gender? gender,
    String? appVersion,
  }) {
    return AppState(
      currentLocale ?? this.currentLocale,
      theme ?? this.theme,
      appVersion ?? this.appVersion,
      gender: gender ?? this.gender,
    );
  }
}

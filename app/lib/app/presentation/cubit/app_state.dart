part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState(
    this.theme,
    this.appVersion,
  );

  final CustomTheme theme;
  final String appVersion;

  @override
  List<Object?> get props => [theme, appVersion];

  AppState copyWith({
    CustomTheme? theme,
    String? appVersion,
  }) {
    return AppState(
      theme ?? this.theme,
      appVersion ?? this.appVersion,
    );
  }
}

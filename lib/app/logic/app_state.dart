part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState(
    this.currentLocale,
    this.theme, {
    this.isLoading = false,
    this.isMale = true,
  });

  final Locale currentLocale;
  final bool isLoading;
  final bool isMale;
  final AppThemes theme;

  @override
  List<Object?> get props => [currentLocale, theme];

  AppState copyWith({Locale? currentLocale, bool? isLoading, bool? isMale}) {
    return AppState(
      currentLocale ?? this.currentLocale,
      theme,
      isLoading: isLoading ?? this.isLoading,
      isMale: isLoading ?? this.isMale,
    );
  }
}

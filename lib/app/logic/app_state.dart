part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState(
    this.currentLocale, {
    this.isLoading = false,
    this.isMale = true,
  });

  final Locale currentLocale;
  final bool isLoading;
  final bool isMale;

  @override
  List<Object?> get props => [currentLocale];

  AppState copyWith({Locale? currentLocale, bool? isLoading, bool? isMale}) {
    return AppState(
      currentLocale ?? this.currentLocale,
      isLoading: isLoading ?? this.isLoading,
      isMale: isLoading ?? this.isMale,
    );
  }
}

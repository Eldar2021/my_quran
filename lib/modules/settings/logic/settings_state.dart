part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({this.currentLocale = const Locale('en')});

  final Locale currentLocale;

  @override
  List<Object?> get props => [currentLocale];

  SettingsState copyWith({Locale? currentLocale}) {
    return SettingsState(
      currentLocale: currentLocale ?? this.currentLocale,
    );
  }
}

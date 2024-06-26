part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.user,
    this.exception,
    this.localeForNow,
    this.genderForNow,
  });

  final UserEntity? user;
  final Exception? exception;
  final String? localeForNow;
  final Gender? genderForNow;

  @override
  List<Object?> get props => [user, exception, localeForNow, genderForNow];

  AuthState copyWith({
    UserEntity? user,
    Exception? exception,
    String? localeForNow,
    Gender? genderForNow,
  }) {
    return AuthState(
      user: user ?? this.user,
      exception: exception ?? this.exception,
      localeForNow: localeForNow ?? this.localeForNow,
      genderForNow: genderForNow ?? this.genderForNow,
    );
  }

  Locale get currentLocale {
    if (user != null) return Locale(user!.localeCode);
    if (localeForNow != null) return Locale(localeForNow!);
    // ignore: deprecated_member_use
    final deviceLocal = window.locale.languageCode;
    return AppLocalizationHelper.getSupportedLocale(deviceLocal);
  }

  Gender get gender {
    if (user != null) return user!.gender;
    if (genderForNow != null) return genderForNow!;
    return Gender.male;
  }

  bool get isAuthedticated => user != null;
}

part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.auth,
    this.exception,
    this.localeForNow,
    this.genderForNow,
  });

  final AuthModel? auth;
  final Object? exception;
  final String? localeForNow;
  final Gender? genderForNow;

  @override
  List<Object?> get props => [
    auth,
    exception,
    localeForNow,
    genderForNow,
  ];

  AuthState copyWith({
    AuthModel? auth,
    Object? exception,
    String? localeForNow,
    Gender? genderForNow,
  }) {
    return AuthState(
      auth: auth ?? this.auth,
      exception: exception ?? this.exception,
      localeForNow: localeForNow ?? this.localeForNow,
      genderForNow: genderForNow ?? this.genderForNow,
    );
  }

  Locale get currentLocale {
    if (auth != null) return Locale(auth!.user.language ?? 'en');
    if (localeForNow != null) return Locale(localeForNow!);
    final deviceLocal = WidgetsBinding.instance.platformDispatcher.locale;
    return AppLocalizationHelper.getSupportedLocale(deviceLocal.languageCode);
  }

  Gender get gender {
    if (auth != null) return auth!.user.gender ?? Gender.male;
    if (genderForNow != null) return genderForNow!;
    return Gender.male;
  }

  AppUiGender get appUiGender {
    return switch (gender) {
      Gender.male => AppUiGender.male,
      Gender.female => AppUiGender.famela,
    };
  }

  MqAppUiGender get mqAppUiGender {
    return switch (gender) {
      Gender.male => MqAppUiGender.male,
      Gender.female => MqAppUiGender.famale,
    };
  }

  bool get isAuthedticated => auth != null;
}

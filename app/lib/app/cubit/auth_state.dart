part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.auth,
    this.locale,
    this.gender,
  });

  final AuthModel? auth;
  final String? locale;
  final Gender? gender;

  @override
  List<Object?> get props => [
    auth,
    locale,
    gender,
  ];

  AuthState copyWith({
    AuthModel? auth,
    String? locale,
    Gender? gender,
  }) {
    return AuthState(
      auth: auth ?? this.auth,
      locale: locale ?? this.locale,
      gender: gender ?? this.gender,
    );
  }

  Locale get currentLocale {
    if (auth != null) return Locale(auth!.user.language?.toLowerCase() ?? 'en');
    if (locale != null) return Locale(locale!);
    final deviceLocal = WidgetsBinding.instance.platformDispatcher.locale;
    return AppLocalizationHelper.getSupportedLocale(deviceLocal.languageCode);
  }

  Gender get currentGender {
    if (auth != null) return auth!.user.gender ?? Gender.male;
    if (gender != null) return gender!;
    return Gender.male;
  }

  AppUiGender get appUiGender {
    return switch (currentGender) {
      Gender.male => AppUiGender.male,
      Gender.female => AppUiGender.famela,
    };
  }

  MqAppUiGender get mqAppUiGender {
    return switch (currentGender) {
      Gender.male => MqAppUiGender.male,
      Gender.female => MqAppUiGender.famale,
    };
  }

  bool get isAuthedticated => auth != null;
}

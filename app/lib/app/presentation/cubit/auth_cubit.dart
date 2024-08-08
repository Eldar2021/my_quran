import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this.getInitialUserUseCase,
    this.googleSignIn,
    this.appleSignIn,
    this.serUserDataUseCase,
    this.patchGenderUseCase,
    this.patchLocaleCodeUseCase,
    this.logoutUseCase,
    this.loginUsecase,
    this.verifyOtpUseCase,
  ) : super(AuthState(user: getInitialUserUseCase.call));

  final GetInitialUserUseCase getInitialUserUseCase;
  final GoogleSignInUseCase googleSignIn;
  final AppleSignInUseCase appleSignIn;
  final SerUserDataUseCase serUserDataUseCase;
  final PatchGenderUseCase patchGenderUseCase;
  final PatchLocaleCodeUseCase patchLocaleCodeUseCase;
  final LogoutUseCase logoutUseCase;
  final EmailLoginUseCase loginUsecase;
  final VerifyOtpUseCase verifyOtpUseCase;

  Future<void> login(String email) async {
    try {
      await loginUsecase(email);
    } catch (e) {
      emit(state.copyWith(exception: Exception(e)));
    }
  }

  Future<AuthState> verifyOtp(String otp, String email) async {
    final user = await verifyOtpUseCase(
      email: email,
      otp: otp,
      languageCode: state.currentLocale.languageCode,
      gender: state.gender,
    );
    user.fold(
      (l) => emit(state.copyWith(exception: l)),
      (r) => emit(state.copyWith(user: r)),
    );
    return state;
  }

  Future<AuthState> signInWithGoogle() async {
    final user = await googleSignIn(
      state.currentLocale.languageCode,
      state.gender,
    );
    user.fold(
      (l) => emit(state.copyWith(exception: l)),
      (r) => emit(state.copyWith(user: r)),
    );
    return state;
  }

  Future<AuthState> signInWithApple() async {
    final user = await appleSignIn(
      state.currentLocale.languageCode,
      state.gender,
    );

    user.fold(
      (l) => emit(state.copyWith(exception: l)),
      (r) => emit(state.copyWith(user: r)),
    );

    return state;
  }

  Future<void> setUserData(UserEntity userEntity) {
    return serUserDataUseCase(userEntity);
  }

  Future<void> saveLocale(String localeCode) async {
    if (state.isAuthedticated) {
      final res = await patchLocaleCodeUseCase(
        userId: state.user!.accessToken,
        localeCode: localeCode,
      );

      res.fold(
        (l) => emit(state.copyWith(exception: l)),
        (r) {
          final newUser = state.user!.copyWith(localeCode: r.localeValue);
          emit(state.copyWith(user: newUser));
        },
      );
    } else {
      emit(state.copyWith(localeForNow: localeCode));
    }
  }

  Future<void> saveGender(Gender gender) async {
    if (state.isAuthedticated) {
      final res = await patchGenderUseCase(
        userId: state.user!.accessToken,
        gender: gender,
      );

      res.fold(
        (l) => emit(state.copyWith(exception: l)),
        (r) {
          final newUser = state.user!.copyWith(gender: r.genderValue);
          emit(state.copyWith(user: newUser));
        },
      );
    } else {
      emit(state.copyWith(genderForNow: gender));
    }
  }

  Future<void> logout() async {
    try {
      await logoutUseCase.call();
      emit(const AuthState());
    } catch (e) {
      emit(state.copyWith(exception: Exception(e)));
    }
  }

  bool get isAuthedticated => state.user != null;
}

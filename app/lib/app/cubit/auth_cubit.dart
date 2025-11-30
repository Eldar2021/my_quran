import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/l10n/l10.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState(user: authRepository.init));

  final AuthRepository authRepository;

  Future<void> loginWithEmail(String email) async {
    try {
      await authRepository.loginWithEmail(email);
    } on Exception catch (e) {
      emit(state.copyWith(exception: e));
    }
  }

  Future<AuthState> verifyOtp(String otp, String email) async {
    try {
      final user = await authRepository.verifyOtp(
        email: email,
        otp: otp,
        languageCode: state.currentLocale.languageCode,
        gender: state.gender,
      );
      emit(state.copyWith(user: user));
      return state;
    } on Exception catch (e) {
      emit(state.copyWith(exception: e));
      return state;
    }
  }

  Future<AuthState> signInWithGoogle() async {
    try {
      final user = await authRepository.signWithGoogle(
        state.currentLocale.languageCode,
        state.gender,
      );
      emit(state.copyWith(user: user));
      return state;
    } on Exception catch (e) {
      emit(state.copyWith(exception: e));
      return state;
    }
  }

  Future<AuthState> signInWithApple() async {
    try {
      final user = await authRepository.signWithApple(
        state.currentLocale.languageCode,
        state.gender,
      );
      emit(state.copyWith(user: user));
    } on Exception catch (e) {
      emit(state.copyWith(exception: e));
    }

    return state;
  }

  Future<void> setUserData(UserModelResponse userModel) {
    return authRepository.setUserData(userModel);
  }

  Future<void> saveLocale(String localeCode) async {
    if (state.isAuthedticated) {
      try {
        final res = await authRepository.patchLocaleCode(
          userId: state.user!.accessToken,
          localeCode: localeCode,
        );
        final newUser = state.user!.copyWith(localeCode: res.localeValue);
        emit(state.copyWith(user: newUser));
      } on Exception catch (e) {
        emit(state.copyWith(exception: e));
        return;
      }
    } else {
      emit(state.copyWith(localeForNow: localeCode));
    }
  }

  Future<void> saveGender(Gender gender) async {
    if (state.isAuthedticated) {
      try {
        final res = await authRepository.patchGender(
          userId: state.user!.accessToken,
          gender: gender,
        );
        final newUser = state.user!.copyWith(gender: res.genderValue);
        emit(state.copyWith(user: newUser));
      } on Exception catch (e) {
        emit(state.copyWith(exception: e));
        return;
      }
    } else {
      emit(state.copyWith(genderForNow: gender));
    }
  }

  Future<void> deleteAccount() async {
    try {
      await authRepository.deleteAccount();
      emit(const AuthState());
    } on Exception catch (e) {
      emit(state.copyWith(exception: e));
    }
  }

  Future<void> logout() async {
    try {
      await authRepository.logout();
      emit(const AuthState());
    } on Exception catch (e) {
      emit(state.copyWith(exception: e));
    }
  }

  bool get isAuthedticated => state.user != null;
}

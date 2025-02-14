import 'dart:ui';

import 'package:equatable/equatable.dart';
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
      emit(state.copyWith(exception: Exception(e)));
    }
  }

  Future<AuthState> verifyOtp(String otp, String email) async {
    final user = await authRepository.verifyOtp(
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
    final user = await authRepository.signWithGoogle(
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
    final user = await authRepository.signWithApple(
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
    return authRepository.setUserData(userEntity);
  }

  Future<void> saveLocale(String localeCode) async {
    if (state.isAuthedticated) {
      final res = await authRepository.patchLocaleCode(
        userId: state.user!.accessToken,
        localeCode: localeCode,
      );

      res.fold((l) => emit(state.copyWith(exception: l)), (r) {
        final newUser = state.user!.copyWith(localeCode: r.localeValue);
        emit(state.copyWith(user: newUser));
      });
    } else {
      emit(state.copyWith(localeForNow: localeCode));
    }
  }

  Future<void> saveGender(Gender gender) async {
    if (state.isAuthedticated) {
      final res = await authRepository.patchGender(
        userId: state.user!.accessToken,
        gender: gender,
      );

      res.fold((l) => emit(state.copyWith(exception: l)), (r) {
        final newUser = state.user!.copyWith(gender: r.genderValue);
        emit(state.copyWith(user: newUser));
      });
    } else {
      emit(state.copyWith(genderForNow: gender));
    }
  }

  Future<void> deleteAccount() async {
    try {
      await authRepository.deleteAccount();
      emit(const AuthState());
    } on Exception catch (e) {
      emit(state.copyWith(exception: Exception(e)));
    }
  }

  Future<void> logout() async {
    try {
      await authRepository.logout();
      emit(const AuthState());
    } on Exception catch (e) {
      emit(state.copyWith(exception: Exception(e)));
    }
  }

  bool get isAuthedticated => state.user != null;
}

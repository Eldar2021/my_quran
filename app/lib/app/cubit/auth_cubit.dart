import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/l10n/l10.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState(auth: authRepository.initialAuth));

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
      final auth = await authRepository.verifyOtp(
        email: email,
        otp: otp,
        languageCode: state.currentLocale.languageCode,
        gender: state.gender,
      );
      emit(state.copyWith(auth: auth));
      return state;
    } on Exception catch (e) {
      emit(state.copyWith(exception: e));
      return state;
    }
  }

  Future<AuthState> signInWithGoogle() async {
    try {
      final auth = await authRepository.signWithGoogle(
        state.currentLocale.languageCode,
        state.gender,
      );
      emit(state.copyWith(auth: auth));
      return state;
    } on Exception catch (e) {
      emit(state.copyWith(exception: e));
      return state;
    }
  }

  Future<AuthState> signInWithApple() async {
    try {
      final auth = await authRepository.signWithApple(
        state.currentLocale.languageCode,
        state.gender,
      );
      emit(state.copyWith(auth: auth));
    } on Exception catch (e) {
      emit(state.copyWith(exception: e));
    }

    return state;
  }

  Future<void> setUserData(AuthModel authModel) {
    return authRepository.saveUser(authModel);
  }

  Future<void> saveLocale(String localeCode) async {
    final auth = state.auth;
    if (auth != null) {
      try {
        final res = await authRepository.patchLocale(
          userId: auth.key,
          localeCode: localeCode,
        );
        final newUser = auth.copyWith(user: res);
        emit(state.copyWith(auth: newUser));
      } on Exception catch (e) {
        emit(state.copyWith(exception: e));
        return;
      }
    } else {
      emit(state.copyWith(localeForNow: localeCode));
    }
  }

  Future<void> toggleNotification({
    bool value = true,
  }) async {
    final auth = state.auth;
    if (auth != null) {
      try {
        final res = await authRepository.toggleNotification(
          userId: auth.key,
          value: value,
        );
        final newUser = auth.copyWith(user: res);
        emit(state.copyWith(auth: newUser));
      } on Exception catch (e) {
        emit(state.copyWith(exception: e));
        return;
      }
    }
  }

  Future<void> saveGender(Gender gender) async {
    final auth = state.auth;
    if (auth != null) {
      try {
        final res = await authRepository.patchGender(
          userId: auth.key,
          gender: gender,
        );
        final newUser = auth.copyWith(user: res);
        emit(state.copyWith(auth: newUser));
      } on Exception catch (e) {
        emit(state.copyWith(exception: e));
        return;
      }
    } else {
      emit(state.copyWith(genderForNow: gender));
    }
  }

  Future<void> patchNotificationToken(String fcmToken) async {
    final auth = state.auth;
    if (auth != null) {
      try {
        await authRepository.setNotificationToken(
          userId: auth.key,
          notificationToken: fcmToken,
          deviceType: Platform.isAndroid ? 'android' : 'ios',
        );
      } on Exception catch (e) {
        emit(state.copyWith(exception: e));
        return;
      }
    }
  }

  Future<void> deleteAccount() async {
    if (!isAuthedticated) return;
    try {
      await authRepository.deleteAccount();
      emit(const AuthState());
    } on Exception catch (e) {
      emit(state.copyWith(exception: e));
    }
  }

  Future<void> logout() async {
    if (!isAuthedticated) return;
    try {
      await authRepository.logout();
      emit(const AuthState());
    } on Exception catch (e) {
      emit(state.copyWith(exception: e));
    }
  }

  bool get isAuthedticated => state.isAuthedticated;
  String get userId => state.auth?.key ?? '';
}

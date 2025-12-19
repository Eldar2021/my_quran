import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.repository) : super(const LoginInitial());

  final AuthRepository repository;

  Future<void> loginWithEmail(String email) async {
    try {
      await repository.loginWithEmail(email);
    } on Exception catch (e) {
      emit(LoginError(e));
    }
  }

  Future<void> verifyOtp({
    required String otp,
    required String email,
    required String languageCode,
    required Gender gender,
  }) async {
    emit(const LoginLoading());
    try {
      final user = await repository.verifyOtp(
        email: email,
        otp: otp,
        languageCode: languageCode,
        gender: gender,
      );
      emit(LoginSuccess(user));
    } on Exception catch (e) {
      emit(LoginError(e));
    }
  }

  Future<void> signInWithGoogle({
    required String languageCode,
    required Gender gender,
  }) async {
    emit(const LoginLoading());
    try {
      final user = await repository.signWithGoogle(
        languageCode,
        gender,
      );
      emit(LoginSuccess(user));
    } on Exception catch (e) {
      emit(LoginError(e));
    }
  }

  Future<void> signInWithApple({
    required String languageCode,
    required Gender gender,
  }) async {
    emit(const LoginLoading());
    try {
      final user = await repository.signWithApple(
        languageCode,
        gender,
      );
      emit(LoginSuccess(user));
    } on Exception catch (e) {
      emit(LoginError(e));
    }
  }
}

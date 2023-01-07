import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/models/models.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.service) : super(AuthState(user: service.init()));

  final AuthService service;

  Future<AuthState> login(String languageCode, Gender gender) async {
    final user = await service.login(languageCode, gender);
    emit(state.copyWith(user: user));
    return state;
  }

  Future<void> logout() async {
    await service.logout();
    emit(const AuthState());
  }

  Future<void> setGender(Gender gender) async {
    await service.changeGender(gender);
    emit(state.copyWith(user: state.user?.copyWith(gender: gender)));
  }
}

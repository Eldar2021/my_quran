import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/models/models.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.storage) : super(AuthState(user: storage.init()));

  final AuthStorage storage;

  Future<void> login(User user) async {
    await storage.login(user);
    emit(state.copyWith(user: user));
  }

  Future<void> logout() async {
    await storage.logout();
    emit(const AuthState());
  }

  void setGender(Gender gender) => emit(state.copyWith(gender: gender));
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/models/models.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.service) : super(AuthState(user: service.init()));

  final AuthService service;

  Future<void> login(User user) async {
    await service.login(user);
    emit(state.copyWith(user: user));
  }

  Future<void> logout() async {
    await service.logout();
    emit(const AuthState());
  }

  Future<void> setGender(Gender gender) async {
    await service.changeGender(gender);
    emit(state.copyWith(user: state.user?.copyWith(gender: gender)));
  }

  void getTotalHatimAndTotalRead() {
    final totalHatim = service.getTotalHatim();
    final totalRead = service.getTotalRead();
    emit(state.copyWith(totalHatim: totalHatim, totalRead: totalRead));
  }

  Future<void> setTotalRead(int value) async {
    final totalRead = value + (state.totalRead ?? 0);
    await service.saveTotalRead(totalRead.toString());
    emit(state.copyWith(totalRead: totalRead));
  }
}

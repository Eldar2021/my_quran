import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/models/models.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.storage) : super(AuthState(user: storage.init()));

  final AuthStorage storage;

  Future<void> setUser(User user) async {
    emit(state.copyWith(user: user));
    await storage.setUser(user);
  }

  void setGender(Gender gender) => emit(state.copyWith(gender: gender));
}

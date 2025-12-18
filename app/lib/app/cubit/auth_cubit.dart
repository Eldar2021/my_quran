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

  Future<void> setUserData(AuthModel authModel) {
    emit(state.copyWith(auth: authModel));
    return authRepository.saveUser(authModel);
  }

  Future<void> updateUserData(
    UpdateUserDataParam param, {
    AuthState? unAuthenticatedNewState,
  }) async {
    final auth = state.auth;
    if (auth != null) {
      try {
        final res = await authRepository.patchUserData(param);
        final newUser = auth.copyWith(user: res);
        emit(state.copyWith(auth: newUser));
      } on Exception catch (e) {
        emit(state.copyWith(exception: e));
        return;
      }
    } else if (unAuthenticatedNewState != null) {
      emit(unAuthenticatedNewState);
    }
  }

  bool get isAuthedticated => state.isAuthedticated;
  String get userId => state.auth?.key ?? '';
}

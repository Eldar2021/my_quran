import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/app/app.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this.getInitialUserUseCase,
    this.loginUseCase,
    this.setGenderUseCase,
  ) : super(AuthState(user: getInitialUserUseCase.call));

  final GetInitialUserUseCase getInitialUserUseCase;
  final LoginUseCase loginUseCase;
  final SetGenderUseCase setGenderUseCase;

  Future<AuthState> login(String languageCode, Gender gender) async {
    final user = await loginUseCase(languageCode, gender);
    user.fold(
      (l) => emit(state.copyWith(exception: l)),
      (r) => emit(state.copyWith(user: r)),
    );
    return state;
  }

  Future<void> setGender(Gender gender) async {
    await setGenderUseCase(gender);
    emit(state.copyWith(user: state.user?.copyWith(gender: gender)));
  }

  bool get isAuthedticated => state.user != null;
}
